//
//  FavoritesManager.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import Combine

final class FavoritesManager: ObservableObject {
    @Published private(set) var favorites: [Product] = []

    private let service: FavoritesServiceProtocol

    init(service: FavoritesServiceProtocol = UserDefaultsFavoritesService()) {
        self.service = service
        self.favorites = service.loadFavorites()
    }

    func toggleFavorite(_ product: Product) {
        service.toggleFavorite(product)
        self.favorites = service.loadFavorites()
    }

    func isFavorite(_ product: Product) -> Bool {
        favorites.contains(where: { $0.id == product.id })
    }
}

