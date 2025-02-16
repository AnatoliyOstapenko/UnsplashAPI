//
//  Store.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation
import Combine

class Store: ObservableObject {
    @Published private(set) var state: AppState

    private var reducer: (AppState, AppAction) -> AppState
    private var cancellables: Set<AnyCancellable> = []

    init(initialState: AppState, reducer: @escaping (AppState, AppAction) -> AppState) {
        self.state = initialState
        self.reducer = reducer
    }

    func dispatch(_ action: AppAction) {
        Logger.log("Dispatching action: \(action)", level: .debug)
        
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }
    }
}
