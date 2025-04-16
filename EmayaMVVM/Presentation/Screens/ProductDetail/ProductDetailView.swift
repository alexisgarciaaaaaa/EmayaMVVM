//
//  ProductDetailView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @State private var selectedColorIndex = 0
    @State private var selectedSize = "9.5"

    let colors: [Color] = [.gray, .black, .blue, .white]
    let sizes: [String] = ["8.5", "9", "9.5", "10", "10.5"]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Spacer()
            }
            .padding(.horizontal)

            AsyncImage(url: URL(string: product.image)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                        .shadow(radius: 10)
                } else {
                    ProgressView()
                        .frame(height: 220)
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

            HStack {
                VStack(alignment: .leading) {
                    Text("Color")
                        .font(.headline)
                    HStack {
                        ForEach(colors.indices, id: \.self) { index in
                            ZStack {
                                Circle()
                                    .fill(colors[index])
                                    .frame(width: 30, height: 30)
                                if selectedColorIndex == index {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                }
                            }
                            .onTapGesture {
                                selectedColorIndex = index
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }

            VStack(alignment: .leading) {
                HStack {
                    Text("Size")
                        .font(.headline)
                    Spacer()
                    Text("UK")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(sizes, id: \.self) { size in
                            Text(size)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(size == selectedSize ? .black : .gray.opacity(0.2))
                                )
                                .foregroundColor(size == selectedSize ? .white : .black)
                                .onTapGesture {
                                    selectedSize = size
                                }
                        }
                    }
                }
            }
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
                    print("Added to bag")
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.white)
                        .frame(width: 32, height: 32)
                        .background(Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding()
        }
        .padding(.top)
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
