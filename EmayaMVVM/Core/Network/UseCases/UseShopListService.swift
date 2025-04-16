//
//  UseShopListService.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI
import Combine

class UseShopListService: UseShopListRepository {
    let apiCLient = URLSessionAPIClient<EmayaAPI>()
    
    func fetchShopList() -> AnyPublisher<[Product], Error> {
        return apiCLient.request(.fetchShopList)
    }
    
    func fetchItemDetail(id: String) -> AnyPublisher<Product, Error> {
        return apiCLient.request(.fetchItemDetail(id: id))
    }
}


class MockShopListService: UseShopListRepository {
    func fetchShopList() -> AnyPublisher<[Product], Error> {
        let mockCats = [
            Product(
                id: 1,
                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                price: 109.95,
                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                category: "men's clothing",
                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                rating: Rating(rate: 3.9, count: 120)
            ),
            Product(
                id: 2,
                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                price: 109.95,
                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                category: "men's clothing",
                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                rating: Rating(rate: 3.9, count: 120)
            ),
            Product(
                id: 3,
                title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
                price: 109.95,
                description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
                category: "men's clothing",
                image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
                rating: Rating(rate: 3.9, count: 120)
            )
        ]
        return Just(mockCats)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchItemDetail(id: String) -> AnyPublisher<Product, Error> {
        let mockDetail = Product(
            id: 1,
            title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
            price: 109.95,
            description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
            category: "men's clothing",
            image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
            rating: Rating(rate: 3.9, count: 120)
        )
        return Just(mockDetail)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
