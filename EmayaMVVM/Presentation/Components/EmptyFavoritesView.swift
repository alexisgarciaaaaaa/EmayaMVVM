//
//  EmptyFavoritesView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import SwiftUI

struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "star")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.6))

            Text("No favorites yet")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)

            Text("Start adding articles to your favorites and they'll show up here.")
                .font(.body)
                .foregroundColor(.gray.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    EmptyFavoritesView()
}
