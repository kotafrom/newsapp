import Foundation

struct NewsArticle: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String?
    let url: URL?
    let imageURL: URL?
    let publishedAt: Date
    let source: String?
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String? = nil,
        url: URL? = nil,
        imageURL: URL? = nil,
        publishedAt: Date,
        source: String? = nil
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.url = url
        self.imageURL = imageURL
        self.publishedAt = publishedAt
        self.source = source
    }
}
