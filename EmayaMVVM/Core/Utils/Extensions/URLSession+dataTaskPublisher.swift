//
//  URLSession+dataTaskPublisher.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import SwiftUI
import Combine

protocol ImageLoaderSession {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(Data, URLResponse), URLError>
}

final class RealImageLoaderSession: ImageLoaderSession {
    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(Data, URLResponse), URLError> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map { ($0.data, $0.response) }
            .eraseToAnyPublisher()
    }
}

