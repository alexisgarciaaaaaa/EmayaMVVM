//
//  AddToFavoritesTip.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//


import TipKit

struct AddToFavoritesTip: Tip {
    var title: Text {
        Text("Add to Favorites")
    }

    var message: Text? {
        Text("Tap the heart to save this item to your favorites.")
    }

    var image: Image? {
        Image(systemName: "heart.fill")
    }
}
