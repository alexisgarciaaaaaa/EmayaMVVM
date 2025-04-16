# EmayaMVVM – iOS App

This is a sample e-commerce app built as a technical test for Emaya. It demonstrates modern iOS development practices using **SwiftUI**, **MVVM**, **Clean Architecture**, and **Apple-native frameworks** such as **Combine** and **TipKit**.

---

## ✅ Project Goals

- Build a scalable, maintainable, and testable SwiftUI app.
- Showcase advanced architectural patterns and UI design.
- Simulate real-world features like search, filters, favorites and image caching.

---

## 🧠 Architecture Overview

### 🧩 MVVM + Clean Architecture

I chose **MVVM (Model-View-ViewModel)** together with **Clean Architecture** principles for the following reasons:

| Why MVVM? | Why Clean Architecture? |
|-----------|--------------------------|
| Keeps UI logic separate from business logic. | Separates concerns: UI, domain, data. |
| Makes Views simpler and reusable. | Makes testing easier and boundaries clearer. |
| Fits SwiftUI naturally via `@StateObject`, `@Binding`, and `Combine`. | Allows inversion of dependencies (e.g. inject mock services easily). |

All business logic lives inside `ViewModels`, which use **protocols (UseCases)** to talk to external services. This allows us to switch between real and mock implementations easily for testing or previewing.


---

## 💾 Favorites: Why UserDefaults instead of CoreData?

I used **UserDefaults** to persist favorite products locally with the following rationale:

| Why UserDefaults | Why not CoreData |
|------------------|------------------|
| We’re only saving simple `[Product]` arrays (lightweight). | Overhead is unnecessary for < 100 items. |
| Encoding/decoding with `Codable` is fast and simple. | CoreData requires managed object setup and context handling. |
| Easier to test, faster to develop, and no persistence stack needed. | CoreData is better suited for large relational datasets. |

Still, the implementation is abstracted behind a `FavoritesServiceProtocol`, so it can be easily replaced with CoreData or CloudKit in the future.

---

## 📸 Image Caching

Images are loaded asynchronously using a custom `ImageLoader` built with `Combine`. We used `NSCache` for in-memory image caching to avoid redundant downloads.

A reusable `CachedAsyncImage` view was built to abstract loading, error handling, and fallback UI for all product images.

---

## 💡 Onboarding with TipKit

We used **Apple's TipKit framework** to provide contextual tooltips (on iOS 17+), such as:

- **"Add to Favorites"** tip

`TipKit` allows tips to appear only once, or according to rules (`.monthly`), making onboarding non-intrusive but effective.

---

## 🔍 Filtering & Search

Categories are dynamically extracted from the product list and presented as selectable filters.

- `@Published selectedFilter` is reactive and updates `filteredProducts`.
- The search text is debounced using Combine, and applies on top of filters.

The result is fast, responsive filtering and search UX with low CPU usage.

---

## 🧪 Unit Testing

The architecture enables clean, isolated unit tests:

| Tested Component         | Description                                |
|--------------------------|--------------------------------------------|
| `ShopListViewModelTests` | Tests fetching, filtering, searching logic |
| `ImageLoaderTests`       | Tests image downloading & caching          |
| `FavoritesServiceTests`  | Tests adding/removing favorites with mocks |

All services (networking, favorites, images) are injected using protocols, allowing use of mock classes for fast, dependency-free testing.

---

## 🛠️ Requirements

- iOS 17+
- Swift 5
- Xcode 15+
- SwiftUI, Combine, TipKit

---

## 📈 Future Improvements

- Deep linking support to product detail pages
- Server-synced favorite list with authentication
- Enhanced animations and transitions in the product detail view
- Offline support with persistence layer abstraction (e.g. SQLite/CoreData)

---

## 👨‍💻 Author

Built by **Bryan García** as part of a technical interview process for Emaya.

