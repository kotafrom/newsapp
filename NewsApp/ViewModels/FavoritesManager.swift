import Foundation

@MainActor
final class FavoritesManager: ObservableObject {
    @Published private(set) var articles: [NewsArticle] = []
    
    private let key = "FavoritesArticles"
    
    init() {
        load()
    }
    
    func isFavorite(_ article: NewsArticle) -> Bool {
        articles.contains { $0.url == article.url }
    }
    
    func toggle(_ article: NewsArticle) {
        if let index = articles.firstIndex(where: { $0.url == article.url }) {
            articles.remove(at: index)
        } else {
            articles.append(article)
        }
        save()
    }
    
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key) else { return }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        articles = (try? decoder.decode([NewsArticle].self, from: data)) ?? []
    }
    
    private func save() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        guard let data = try? encoder.encode(articles) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }
}
