//
//  FavoritesServiceProtocol.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import SwiftUI

protocol FavoritesServiceProtocol {
    func loadFavorites() -> [Product]
    func saveFavorites(_ favorites: [Product])
    func isFavorite(_ product: Product) -> Bool
    func toggleFavorite(_ product: Product)
}
