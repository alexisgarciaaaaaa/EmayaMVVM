//
//  EmayaMVVMTests.swift
//  EmayaMVVMTests
//
//  Created by bryangarcia on 15/4/25.
//

import XCTest
import Combine
@testable import EmayaMVVM

final class ShopListViewModelTests: XCTestCase {
    var viewModel: ShopListViewModel!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        viewModel = ShopListViewModel(useCase: MockShopListService())
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchProductsSuccess() {
        let expectation = XCTestExpectation(description: "Products loaded")

        viewModel.$products
            .dropFirst()
            .sink { products in
                XCTAssertEqual(products.count, 3)
                XCTAssertEqual(products.first?.title, "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchProducts()

        wait(for: [expectation], timeout: 2)
    }

    func testInitialSelectedFilterIsSet() {
        let expectation = XCTestExpectation(description: "Selected filter set")

        viewModel.$selectedFilter
            .dropFirst()
            .sink { filter in
                XCTAssertEqual(filter, "All")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.fetchProducts()

        wait(for: [expectation], timeout: 2)
    }

    func testFilteringByCategory() {
        let expectation = XCTestExpectation(description: "Filtered by category")

        viewModel.fetchProducts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.filterProducts(by: "Men's Clothing")
            XCTAssertEqual(self.viewModel.filteredProducts.count, 3)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testSearchTextFiltersProducts() {
        let expectation = XCTestExpectation(description: "Filtered by search text")

        viewModel.fetchProducts()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewModel.searchText = "forest"
        }

        viewModel.$filteredProducts
            .dropFirst(2) // drop first load and first searchText change
            .sink { filtered in
                XCTAssertEqual(filtered.count, 3)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2)
    }
}
