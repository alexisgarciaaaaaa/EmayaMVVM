//
//  UserDefaultsFavoritesService.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import Foundation

import Foundation

final class UserDefaultsFavoritesService: FavoritesServiceProtocol {
    private let key = "favorite_products"

    func loadFavorites() -> [Product] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Product].self, from: data)) ?? []
    }

    func saveFavorites(_ favorites: [Product]) {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func isFavorite(_ product: Product) -> Bool {
        loadFavorites().contains(where: { $0.id == product.id })
    }

    func toggleFavorite(_ product: Product) {
        var current = loadFavorites()
        if let index = current.firstIndex(where: { $0.id == product.id }) {
            current.remove(at: index)
        } else {
            current.append(product)
        }
        saveFavorites(current)
    }
}

