//
//  ProductDetailView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @Environment(\.dismiss) private var dismiss
    let product: Product

    var body: some View {
        VStack(spacing: 20) {
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
            }
            .padding(.horizontal)

            if let url = URL(string: product.image) {
                CachedAsyncImage(url: url) {
                    AnyView(
                        ProgressView()
                            .frame(height: 220)
                    )
                } image: { uiImage in
                    AnyView(
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 220)
                            .shadow(radius: 10)
                    )
                }
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(product.category.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(product.title.uppercased())
                    .font(.title2.bold())
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Description")
                    .font(.headline)
                Text(product.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(4)
            }
            .padding(.horizontal)


            Spacer()

            HStack {
                Text(String(format: "$%.2f", product.price))
                    .font(.title3.bold())
                Spacer()
                Button(action: {
                    favoritesManager.toggleFavorite(product)
                }) {
                    Image(systemName: favoritesManager.isFavorite(product) ? "heart.fill" : "heart")
                           .foregroundColor(.white)
                           .frame(width: 32, height: 32)
                           .background(Color.black)
                           .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding()
        }
        .padding(.top)
        .navigationBarBackButtonHidden()
    }
}

// MARK: - Preview
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(
            id: 1,
            title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            price: 109.95,
            description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            category: "men's clothing",
            image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            rating: Rating(rate: 3.9, count: 120)
        ))
    }
}
