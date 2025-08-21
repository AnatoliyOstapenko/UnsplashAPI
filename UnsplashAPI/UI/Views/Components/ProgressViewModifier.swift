//
//  ProgressViewModifier.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 8/21/25.
//

import SwiftUI

struct ProgressViewModifier: ViewModifier {
    let isShowing: Bool
    func body(content: Content) -> some View {
        content
            .overlay {
                if isShowing {
                    ProgressView("Fetching...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.2))
                }
            }
    }
}

extension View {
    func progressView(_ isShowing: Bool) -> some View {
        modifier(ProgressViewModifier(isShowing: isShowing))
    }
}
