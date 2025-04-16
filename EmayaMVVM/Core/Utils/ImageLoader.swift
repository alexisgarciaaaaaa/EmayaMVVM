//
//  ImageLoader.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    enum LoadState {
        case loading
        case success(UIImage)
        case failure
    }

    @Published var state: LoadState = .loading

    private var cancellable: AnyCancellable?
    private let url: URL
    private let session: ImageLoaderSession

    init(url: URL, session: ImageLoaderSession = RealImageLoaderSession()) {
        self.url = url
        self.session = session
        loadImage()
    }

    private func loadImage() {
        let cacheKey = NSString(string: url.absoluteString)

        if let cached = ImageCache.shared.object(forKey: cacheKey) {
            self.state = .success(cached)
            return
        }

        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)

        cancellable = session.dataTaskPublisher(for: request)
            .tryMap { data, _ -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw URLError(.cannotDecodeContentData)
                }
                return image
            }
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                if case .failure = result {
                    self?.state = .failure
                }
            }, receiveValue: { [weak self] image in
                ImageCache.shared.setObject(image, forKey: cacheKey)
                self?.state = .success(image)
            })
    }

    deinit {
        cancellable?.cancel()
    }
}
