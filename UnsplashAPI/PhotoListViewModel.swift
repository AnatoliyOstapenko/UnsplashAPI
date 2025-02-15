//
//  PhotoListViewModel.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI
import Combine

class PhotoListViewModel: ObservableObject {
    @Published var photos: [UnsplashPhoto] = []
    @Published var errorMessage: APIError?
    @Published var hasError = false
    @Published var isLoading = false

    private let apiService: APIServiceProtocol
    private var cancellables: Set<AnyCancellable> = []

    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
        fetchPhotos()
    }

    func fetchPhotos() {
        isLoading = true
        
        apiService.fetchPhotos()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                
                if case .failure(let apiError) = completion {
                    Logger.log("Error fetching photos: \(apiError)", level: .error)
                    self.hasError = true
                    self.errorMessage = apiError
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.hasError = false
                self.photos = response
            }.store(in: &cancellables)
    }
}

