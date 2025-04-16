//
//  CachedAsyncImage.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 15/4/25.
//

import SwiftUI

struct CachedAsyncImage: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: AnyView
    private let image: (UIImage) -> AnyView

    init(
        url: URL,
        @ViewBuilder placeholder: @escaping () -> AnyView = {
            AnyView(ProgressView())
        },
        @ViewBuilder image: @escaping (UIImage) -> AnyView
    ) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.placeholder = placeholder()
        self.image = image
    }

    var body: some View {
        switch loader.state {
        case .loading:
            placeholder
        case .failure:
            AnyView(
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                    .foregroundColor(.gray)
            )
        case .success(let uiImage):
            image(uiImage)
        }
    }
}
