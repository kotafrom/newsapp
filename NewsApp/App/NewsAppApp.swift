import SwiftUI

@main
struct NewsAppApp: App {
    @StateObject private var favorites = FavoritesManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                NewsListView()
                    .tabItem {
                        Label("Новости", systemImage: "newspaper")
                    }
                FavoritesView()
                    .tabItem {
                        Label("Избранное", systemImage: "heart")
                    }
            }
            .environmentObject(favorites)
        }
    }
}
