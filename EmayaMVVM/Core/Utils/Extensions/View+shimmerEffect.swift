//
//  View+shimmerEffect.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import SwiftUI

extension View {
    func shimmerEffect() -> some View {
        self
            .modifier(ShimmerModifier())
    }
}
