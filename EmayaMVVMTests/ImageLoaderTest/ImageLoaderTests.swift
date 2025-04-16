//
//  ImageLoaderTests.swift
//  EmayaMVVMTests
//
//  Created by bryangarcia on 16/4/25.
//

import XCTest
import Combine
import UIKit
@testable import EmayaMVVM

final class ImageLoaderTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []

    func testImageLoaderSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Image loaded")
        let image = UIImage(systemName: "cart")!
        let imageData = image.pngData()!

        let session = MockImageLoaderSession(result: .success(imageData))
        let loader = ImageLoader(url: URL(string: "https://example.com")!, session: session)

        // When
        loader.$state
            .dropFirst()
            .sink { state in
                // Then
                if case .success(let loadedImage) = state {
                    XCTAssertNotNil(loadedImage)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }

    func testImageLoaderFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Image loading failed")
        let session = MockImageLoaderSession(result: .failure(URLError(.badURL)))
        let loader = ImageLoader(url: URL(string: "https://example.com")!, session: session)

        // When
        loader.$state
            .dropFirst()
            .sink { state in
                // Then
                if case .failure = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 2.0)
    }
}

