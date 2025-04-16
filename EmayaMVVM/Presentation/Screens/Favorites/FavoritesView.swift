//
//  FavoritesView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        dismiss()
                    }
                Spacer()
                Text("Favorites")
                    .font(.largeTitle.bold())
                Spacer()
            }
            .padding(.horizontal)
            if favoritesManager.favorites.isEmpty {
                Spacer()
                Text("No favorites yet.")
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
            } else {
                ScrollView {
                    LazyVStack(spacing: 24) {
                        ForEach(favoritesManager.favorites) { product in
                            NavigationLink(destination: ProductDetailView(product: product)) {
                                ProductCardView(product: product)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

