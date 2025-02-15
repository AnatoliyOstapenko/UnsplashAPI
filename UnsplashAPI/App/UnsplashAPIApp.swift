//
//  UnsplashAPIApp.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import SwiftUI

@main
struct UnsplashAPIApp: App {
    private let apiService = APIService()

    var body: some Scene {
        WindowGroup {
            PhotoListView(viewModel: PhotoListViewModel(apiService: apiService))
        }
    }
}
