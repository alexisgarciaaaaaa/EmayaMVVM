//
//  ProductListView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject private var viewModel: ShopListViewModel
    
    init(viewModel: ShopListViewModel = ShopListViewModel(useCase: UseShopListService())) {
        let isUITesting = ProcessInfo.processInfo.arguments.contains("--uitesting")
        let mockService = MockShopListService()
        let viewModelInject = ShopListViewModel(useCase: isUITesting ? mockService : UseShopListService())
        _viewModel = StateObject(wrappedValue: viewModelInject)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                
                HStack {
                    Text("DISCOVER")
                        .font(.largeTitle.bold())
                    
                    Spacer()
                }
                .padding(.horizontal)

                TextField("Search", text: $viewModel.searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.categories, id: \.self) { filter in
                            Text(filter)
                                .font(.subheadline.bold())
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(
                                    viewModel.selectedFilter == filter
                                    ? Color.black
                                    : Color(.systemGray5)
                                )
                                .foregroundColor(viewModel.selectedFilter == filter ? .white : .black)
                                .cornerRadius(20)
                                .onTapGesture {
                                    viewModel.selectedFilter = filter
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                if viewModel.hasNoResults {
                    Spacer()
                    EmptySearchView {
                        viewModel.searchText = ""
                    }
                    .padding(.bottom, 200)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 24) {
                            ForEach(viewModel.filteredProducts) { product in
                                ProductCardView(product: product)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .onAppear(perform: viewModel.fetchProducts)
    }
}

#Preview {
    ProductListView(viewModel: ShopListViewModel(useCase: UseShopListService()))
}
