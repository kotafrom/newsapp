import Foundation

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService: NewsAPIServiceProtocol
    
    init(apiService: NewsAPIServiceProtocol = NewsAPIService()) {
        self.apiService = apiService
    }
    
    func fetchNews() async {
        isLoading = true
        errorMessage = nil
        
        do {
            var fetched = try await apiService.fetchArticles().filter { $0.imageURL != nil }
            fetched = await filterAccessibleArticles(fetched)
            articles = fetched
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    /// Убирает статьи, которые отдают 40x при попытке доступа
    private func filterAccessibleArticles(_ articles: [NewsArticle]) async -> [NewsArticle] {
        await withTaskGroup(of: (NewsArticle, Bool).self) { group in
            for article in articles {
                group.addTask {
                    let accessible = await Self.checkURLAccessible(article.url)
                    return (article, accessible)
                }
            }
            
            var result: [NewsArticle] = []
            for await (article, accessible) in group {
                if accessible {
                    result.append(article)
                }
            }
            return result
        }
    }
    
    private static func checkURLAccessible(_ url: URL?) async -> Bool {
        guard let url else { return false }
        
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        request.setValue("Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15", forHTTPHeaderField: "User-Agent")
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return false }
            let code = httpResponse.statusCode
            if (200...299).contains(code) { return true }
            if code == 405 { return true } // HEAD не поддерживается — считаем доступным
            return false // 40x и другие — исключаем
        } catch {
            return false
        }
    }
}
