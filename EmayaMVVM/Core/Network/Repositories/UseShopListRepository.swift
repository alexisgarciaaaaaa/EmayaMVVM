//
//  UseShopListRepository.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI
import Combine

protocol UseShopListRepository {
    func fetchShopList() -> AnyPublisher<[Product], Error>
    func fetchItemDetail(id: String) -> AnyPublisher<Product, Error>
}
