//
//  SnackBarHelper.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 8/21/25.
//

import SwiftUI
import Combine

class SnackBarHelper: ObservableObject {
    @Published var snackBar: Snackbar = .error("")
    @Published var isVisible: Bool = false

    private var dismissCancellable: AnyCancellable?
   
    func show(snackBar: Snackbar, duration: TimeInterval = 2.5) {
        self.snackBar = snackBar
        self.isVisible = true
        
        // Cancel existing timer if any
        dismissCancellable?.cancel()
        
        // Auto dismiss after duration
        dismissCancellable = Just(())
            .delay(for: .seconds(duration), scheduler: DispatchQueue.main)
            .sink { [weak self] in
                self?.isVisible = false
            }
    }

    func dismiss() {
        isVisible = false
        dismissCancellable?.cancel()
    }
}
