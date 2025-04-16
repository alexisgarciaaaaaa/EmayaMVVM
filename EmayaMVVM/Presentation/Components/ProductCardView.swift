//
//  ProductCardView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI

struct ProductCardView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 16) {

            if let url = URL(string: product.image) {
                CachedAsyncImage(url: url) {
                    AnyView(
                        ProgressView()
                            .frame(width: 80, height: 80)
                    )
                } image: { uiImage in
                    AnyView(
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .cornerRadius(12)
                    )
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(1)

                Text(product.category.capitalized)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Text("$ \(String(format: "%.2f", product.price))")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.black)

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .frame(width: 32, height: 32)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: Product(
            id: 1,
            title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            price: 109.95,
            description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            category: "men's clothing",
            image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            rating: Rating(rate: 3.9, count: 120)
        ))
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
