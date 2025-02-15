//
//  ErrorSnackbarView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI

struct ErrorSnackbarView: View {
    let message: String
    let onRetry: (() -> Void)?
    let onDismiss: (() -> Void)?

    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Error")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Spacer()
                
                Button("Retry") {
                    onRetry?()
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.2))
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button(action: { onDismiss?() }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.white.opacity(0.2))
                        .clipShape(Circle())
                }
            }
            .padding()
            .background(Color.red.opacity(0.9))
            .cornerRadius(12)
            .padding(.horizontal, 20)
        }
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut, value: message)
    }
}
