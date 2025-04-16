//
//  UserDefaultsFavoritesServiceTests.swift
//  EmayaMVVMTests
//
//  Created by bryangarcia on 16/4/25.
//

import XCTest
@testable import EmayaMVVM

final class UserDefaultsFavoritesServiceTests: XCTestCase {
    var service: UserDefaultsFavoritesService!
    let testKey = "favorite_products"
    var defaults: UserDefaults!

    let mockProduct = Product(
        id: 1,
        title: "Test Backpack",
        price: 50.0,
        description: "Test Description",
        category: "Test",
        image: "https://example.com",
        rating: Rating(rate: 5.0, count: 10)
    )

    override func setUp() {
        super.setUp()
        defaults = UserDefaults(suiteName: "TestSuite")
        defaults.removePersistentDomain(forName: "TestSuite")
        service = UserDefaultsFavoritesService(userDefaults: defaults, key: testKey)
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: "TestSuite")
        service = nil
        super.tearDown()
    }

    func testSaveAndLoadFavorites() {
        service.saveFavorites([mockProduct])
        let loaded = service.loadFavorites()
        XCTAssertEqual(loaded.count, 1)
        XCTAssertEqual(loaded.first?.id, mockProduct.id)
    }

    func testIsFavoriteReturnsTrueAfterSaving() {
        service.saveFavorites([mockProduct])
        XCTAssertTrue(service.isFavorite(mockProduct))
    }

    func testToggleFavoriteAddsAndRemoves() {
        service.toggleFavorite(mockProduct)
        XCTAssertTrue(service.isFavorite(mockProduct))

        service.toggleFavorite(mockProduct)
        XCTAssertFalse(service.isFavorite(mockProduct))
    }

    func testLoadFavoritesWhenEmpty() {
        let loaded = service.loadFavorites()
        XCTAssertEqual(loaded.count, 0)
    }
}

