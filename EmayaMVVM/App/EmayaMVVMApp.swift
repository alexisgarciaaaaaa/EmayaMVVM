//
//  EmayaProductCatalogAppApp.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI
import TipKit

@main
struct EmayaProductCatalogAppApp: App {
    @StateObject private var favoritesManager = FavoritesManager()
    init() {
        do {
            try Tips.configure([
                .displayFrequency(.monthly),
                .datastoreLocation(.applicationDefault)
            ])
        }
        catch {
            print("Error initializing tips: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(favoritesManager)
        }
    }
}
