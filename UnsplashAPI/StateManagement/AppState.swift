//
//  AppState.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

struct AppState {
    var photos: [UnsplashPhoto] = []
    var isLoading: Bool = false
    var error: APIError? = nil
}
