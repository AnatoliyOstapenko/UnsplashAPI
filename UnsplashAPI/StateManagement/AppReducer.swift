//
//  AppReducer.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

func appReducer(state: AppState, action: AppAction) -> AppState {
    var newState = state

    switch action {
    case .fetchPhotos:
        newState.isLoading = true
        newState.error = nil
    case .fetchPhotosSuccess(let photos):
        newState.photos = photos
        newState.isLoading = false
    case .fetchPhotosFailure(let error):
        newState.error = error
        newState.isLoading = false
    }

    return newState
}
