import Foundation

// Протокол для тестов и подмены сервиса
protocol NewsAPIServiceProtocol {
    func fetchArticles() async throws -> [NewsArticle]
}

final class NewsAPIService: NewsAPIServiceProtocol {
    private let apiKey = "be0b7f7cbaaa4b13b0c704ce018f6e8d"
    private let baseURL = "https://newsapi.org/v2"
    
    func fetchArticles() async throws -> [NewsArticle] {
        guard let url = URL(string: "\(baseURL)/top-headlines?country=us&apiKey=\(apiKey)") else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try decoder.decode(NewsAPIResponse.self, from: data)
        return result.articles.compactMap { $0.toNewsArticle() }
    }
}

// MARK: - API Response (JSON структура)
private struct NewsAPIResponse: Codable {
    let articles: [NewsAPIArticle]
}

private struct NewsAPIArticle: Codable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let source: NewsAPISource?
    
    func toNewsArticle() -> NewsArticle? {
        guard let title = title, !title.isEmpty else { return nil }
        let date = publishedAt.flatMap { ISO8601DateFormatter().date(from: $0) } ?? Date()
        return NewsArticle(
            title: title,
            description: description,
            url: url.flatMap { URL(string: $0) },
            imageURL: urlToImage.flatMap { URL(string: $0) },
            publishedAt: date,
            source: source?.name
        )
    }
}

private struct NewsAPISource: Codable {
    let name: String?
}
