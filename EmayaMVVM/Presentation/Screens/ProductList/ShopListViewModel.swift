//
//  ShopListViewModel.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI
import Combine

class ShopListViewModel: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var errorMessage: String?
    @Published private(set) var categories: [String] = []
    @Published private(set) var filteredProducts: [Product] = []
    @Published var searchText: String = ""
    @Published var selectedFilter: String = "" {
        didSet {
            filterProducts(by: selectedFilter)
        }
    }
    @Published var isFetchingMore: Bool = false
    
    var hasNoResults: Bool {
        return !selectedFilter.isEmpty && filteredProducts.isEmpty
    }
    
    private let useCase: UseShopListRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: UseShopListRepository) {
        self.useCase = useCase
        bindingSetup()
    }
    
    func fetchProducts() {
        errorMessage = nil
        useCase.fetchShopList()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    if case .failure(let error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] products in
                    self?.products = products
                    self?.filteredProducts = products
                    self?.categories = self?.extractCategories(from: products) ?? []
                    self?.selectedFilter = self?.categories.first ?? ""
                }
            )
            .store(in: &cancellables)
    }
    
    func filterProducts(by category: String) {
        let base = category.isEmpty || category == "All"
            ? products
            : products.filter { $0.category.capitalized == category }

        // Si hay texto de búsqueda, se filtrará después con applySearch()
        if searchText.isEmpty {
            filteredProducts = base
        } else {
            applySearch()
        }
    }
    
    private func bindingSetup() {
        $searchText
                .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
                .sink { [weak self] _ in
                    self?.applySearch()
                }
                .store(in: &cancellables)
    }

    private func extractCategories(from products: [Product]) -> [String] {
        let rawCategories = products.map { $0.category.capitalized }
        let unique = Array(Set(rawCategories)).sorted()
        return ["All"] + unique
    }

    private func applySearch() {
        guard !searchText.isEmpty else {
            filterProducts(by: selectedFilter)
            return
        }

        let baseList = selectedFilter.isEmpty || selectedFilter == "All"
            ? products
            : products.filter { $0.category.capitalized == selectedFilter }

        filteredProducts = baseList.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.description.localizedCaseInsensitiveContains(searchText)
        }
    }
}
