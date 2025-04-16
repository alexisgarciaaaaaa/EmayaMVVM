//
//  EmptySearchView.swift
//  EmayaMVVM
//
//  Created by bryangarcia on 16/4/25.
//

import SwiftUI

struct EmptySearchView: View {
    var title: String = "No results found"
    var subtitle: String = "We couldn’t find any items matching your search."
    var imageName: String = "magnifyingglass.circle"
    var action: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray.opacity(0.6))
            
            Text(title)
                .font(.title2.bold())
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let action = action {
                Button(action: action) {
                    Text("Clear Search")
                        .padding(.vertical, 10)
                        .padding(.horizontal, 24)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
