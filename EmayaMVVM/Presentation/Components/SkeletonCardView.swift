//
//  SkeletonCardView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import SwiftUI

struct SkeletonCardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 100)

            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 16)

            RoundedRectangle(cornerRadius: 6)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 100, height: 16)
        }
        .padding()
        .background(Color.gray.opacity(0.15))
        .cornerRadius(16)
        .shimmerEffect()
    }
}
