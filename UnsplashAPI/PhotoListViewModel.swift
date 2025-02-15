//
//  PhotoListViewModel.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI
import Combine

class PhotoListViewModel: ObservableObject {
    @Published var state: AppState
    private let store: Store
    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(store: Store, apiService: APIServiceProtocol) {
        self.store = store
        self.apiService = apiService
        self.state = store.state

        store.$state
            .receive(on: DispatchQueue.main)
            .assign(to: &$state)

        fetchPhotos()
    }

    func fetchPhotos() {
        store.dispatch(.fetchPhotos)

        apiService.fetchPhotos()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                    if case .failure(let apiError) = completion {
                        self.store.dispatch(.fetchPhotosFailure(apiError))
                        Logger.log("Error fetching photos: \(apiError)", level: .error)
                    }
            }, receiveValue: { photos in
                self.store.dispatch(.fetchPhotosSuccess(photos))
            })
            .store(in: &cancellables)
    }
}

