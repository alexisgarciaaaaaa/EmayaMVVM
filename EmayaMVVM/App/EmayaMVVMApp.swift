//
//  EmayaProductCatalogAppApp.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI

@main
struct EmayaProductCatalogAppApp: App {
    @StateObject private var favoritesManager = FavoritesManager()
    var body: some Scene {
        WindowGroup {
            ProductListView()
                .environmentObject(favoritesManager)
        }
    }
}
