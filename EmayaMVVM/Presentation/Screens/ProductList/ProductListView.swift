//
//  ProductListView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI

struct ProductListView: View {
    @State private var searchText: String = ""
    @State private var selectedFilter: String = "New Release"

    let filters = ["New Release", "Men", "Women", "Kids"]
    let products: [Product]

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Text("DISCOVER")
                        .font(.largeTitle.bold())
                    
                    Spacer()
                }
                .padding(.horizontal)

                TextField("Search", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(filters, id: \.self) { filter in
                            Text(filter)
                                .font(.subheadline.bold())
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    selectedFilter == filter
                                    ? Color.black
                                    : Color(.systemGray5)
                                )
                                .foregroundColor(selectedFilter == filter ? .white : .black)
                                .cornerRadius(20)
                                .onTapGesture {
                                    selectedFilter = filter
                                }
                        }
                    }
                    .padding(.horizontal)
                }

                ScrollView {
                    LazyVStack(spacing: 24) {
                        ForEach(products) { product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(products: [
            Product(
                id: 1,
                title: "Nike Air Max SC",
                price: 97.88,
                description: "Men's Shoes",
                category: "Men's Shoes",
                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                rating: Rating(rate: 4.5, count: 200)
            ),
            Product(
                id: 2,
                title: "Nike Air Zoom",
                price: 143.50,
                description: "Men's Shoes",
                category: "Men's Shoes",
                image: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg",
                rating: Rating(rate: 4.2, count: 350)
            )
        ])
    }
}
