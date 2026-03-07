# 📰 NewsApp

A modern iOS news reader app built with SwiftUI. Stay updated with top headlines from around the world and save your favorite articles for later.

![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-iOS%2017+-blue?style=flat-square)
![SwiftUI](https://img.shields.io/badge/SwiftUI-Latest-green?style=flat-square)

---

## ✨ Features

- **Top headlines** — Latest news from the US via [NewsAPI.org](https://newsapi.org)
- **Favorites** — Save articles to bookmarks; data persists locally
- **Article detail** — Read full articles in an in-app browser (WKWebView)
- **Pull-to-refresh** — Refresh the feed with a swipe
- **Clean UI** — News cards with images, date, and source
- **Error handling** — Clear feedback when something goes wrong

---

## 🛠 Tech Stack

- **SwiftUI** — Declarative UI framework
- **Swift Concurrency** — async/await for network requests
- **MVVM** — Architecture with ViewModel and `@StateObject`
- **NewsAPI.org** — News data source
- **UserDefaults** — Favorites persistence

---

## 📋 Requirements

- Xcode 15+
- iOS 17.0+
- Swift 5.9+

---

## 🚀 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/NewsApp.git
   cd NewsApp
   ```

2. Open the project in Xcode:
   ```bash
   open NewsApp.xcodeproj
   ```

3. *(Optional)* Replace the API key in `NewsApp/Networking/NewsAPIService.swift` with your own.  
   Get a free key at [newsapi.org](https://newsapi.org/register).

4. Build and run (⌘R).

---

## 📁 Project Structure

```
NewsApp/
├── App/
│   └── NewsAppApp.swift        # App entry point, TabView
├── Models/
│   └── NewsArticle.swift       # Article model
├── ViewModels/
│   ├── NewsViewModel.swift     # News loading logic
│   └── FavoritesManager.swift  # Favorites management
├── Views/
│   ├── NewsListView.swift      # Main news feed screen
│   ├── NewsArticleRowView.swift
│   ├── ArticleDetailView.swift # Article view in WebView
│   └── FavoritesView.swift
└── Networking/
    └── NewsAPIService.swift    # NewsAPI integration
```

---

## 🔑 API Key

This app uses [NewsAPI.org](https://newsapi.org). The free tier includes:
- 100 requests per day
- Top headlines by country

The default key is in the code. For production, use your own API key.

---

## 📄 License

MIT License

---

*Built with ❤️ using SwiftUI*
