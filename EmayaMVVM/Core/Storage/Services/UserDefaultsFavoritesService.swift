//
//  UserDefaultsFavoritesService.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import Foundation

final class UserDefaultsFavoritesService: FavoritesServiceProtocol {
    private let key: String
    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard, key: String = "favorite_products") {
        self.userDefaults = userDefaults
        self.key = key
    }

    func loadFavorites() -> [Product] {
        guard let data = userDefaults.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([Product].self, from: data)) ?? []
    }

    func saveFavorites(_ favorites: [Product]) {
        if let data = try? JSONEncoder().encode(favorites) {
            userDefaults.set(data, forKey: key)
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
