//
//  MockImageLoaderSession.swift
//  EmayaMVVMTests
//
//  Created by bryangarcia on 16/4/25.
//

import Combine
import Foundation
@testable import EmayaMVVM

final class MockImageLoaderSession: ImageLoaderSession {
    var result: Result<Data, URLError>

    init(result: Result<Data, URLError>) {
        self.result = result
    }

    func dataTaskPublisher(for request: URLRequest) -> AnyPublisher<(Data, URLResponse), URLError> {
        switch result {
        case .success(let data):
            let response = URLResponse(
                url: request.url!,
                mimeType: "image/png",
                expectedContentLength: data.count,
                textEncodingName: nil
            )
            return Just((data, response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}

