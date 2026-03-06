import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesManager
    
    var body: some View {
        NavigationStack {
            Group {
                if favorites.articles.isEmpty {
                    ContentUnavailableView(
                        "Нет избранного",
                        systemImage: "heart.slash",
                        description: Text("Добавляйте понравившиеся новости сердечком")
                    )
                } else {
                    List(favorites.articles) { article in
                        NavigationLink {
                            ArticleDetailView(article: article)
                        } label: {
                            NewsArticleRowView(article: article, showFavoriteButton: true)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Избранное")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Image(systemName: "heart.fill")
                            .font(.title2)
                            .foregroundStyle(.red)
                        Text("Избранное")
                            .font(.title2.weight(.bold))
                    }
                }
            }
        }
    }
}
