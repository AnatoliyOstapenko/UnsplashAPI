//
//  SnackbarView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 8/21/25.
//

import SwiftUI

enum SnackbarState {
    case success, warning, error

    var background: Color {
        switch self {
        case .success: return .green
        case .warning: return .orange
        case .error: return .red
        }
    }

    var image: Image {
        switch self {
        case .success: return Image(systemName: "checkmark.circle")
        case .warning: return Image(systemName: "exclamationmark.triangle")
        case .error: return Image(systemName: "exclamationmark.circle")
        }
    }
}

struct Snackbar {
    let message: String
    let state: SnackbarState
    
    static func success(_ message: String) -> Snackbar {
        Snackbar(message: message, state: .success)
    }
    static func warning(_ message: String) -> Snackbar {
        Snackbar(message: message, state: .warning)
    }
    static func error(_ message: String) -> Snackbar {
        Snackbar(message: message, state: .error)
    }
}

struct SnackbarView: View {
    let snackbar: Snackbar
    @Binding var isVisible: Bool
    
    var body: some View {
        VStack {
            Spacer()
            if isVisible {
                HStack {
                    snackbar.state.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                    Text(snackbar.message)
                        .font(.system(size: 14, weight: .semibold))
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 16)
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .frame(maxWidth: .infinity)
                .background(snackbar.state.background)
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 6)
                .padding(.horizontal, 16)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isVisible)
    }
}

struct SnackBarModifier: ViewModifier {
    @ObservedObject var snackBarHelper: SnackBarHelper

    func body(content: Content) -> some View {
        content
            .overlay {
                SnackbarView(
                    snackbar: snackBarHelper.snackBar,
                    isVisible: $snackBarHelper.isVisible
                )
            }
    }
}

extension View {
    func snackBar(using helper: SnackBarHelper) -> some View {
        self.modifier(SnackBarModifier(snackBarHelper: helper))
    }
}

