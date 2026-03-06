import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if let error = viewModel.errorMessage, viewModel.articles.isEmpty {
                    ContentUnavailableView {
                        Label("Ошибка", systemImage: "exclamationmark.triangle")
                    } description: {
                        Text(error)
                    }
                } else if viewModel.isLoading && viewModel.articles.isEmpty {
                    ProgressView()
                } else {
                    List(viewModel.articles) { article in
                        NavigationLink {
                            ArticleDetailView(article: article)
                        } label: {
                            NewsArticleRowView(article: article, showFavoriteButton: true)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .overlay {
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                        }
                    }
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 10) {
                        Image(systemName: "newspaper.fill")
                            .font(.title2)
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.blue)
                        Text("Свежие новости")
                            .font(.title2.weight(.bold))
                    }
                }
            }
            .refreshable {
                await viewModel.fetchNews()
            }
            .task {
                await viewModel.fetchNews()
            }
        }
    }
}
