import SwiftUI
import WebKit

struct ArticleDetailView: View {
    let article: NewsArticle
    
    var body: some View {
        Group {
            if let url = article.url {
                WebView(url: url)
            } else {
                ContentUnavailableView(
                    "Нет ссылки",
                    systemImage: "link",
                    description: Text("У этой статьи нет URL")
                )
            }
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
