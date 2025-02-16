//
//  ErrorEmptyView.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI

enum EmptyType {
    case none
    case emptyList
    
    var content: String {
        switch self {
        case .none:
            return ""
        case .emptyList:
            return "Empty Photo List\n Check your internet connection"
        }
    }
}

struct ErrorEmptyView: View {
    let type: EmptyType
    
    var body: some View {
        VStack {
            if type != .none {
                Text(type.content)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}
