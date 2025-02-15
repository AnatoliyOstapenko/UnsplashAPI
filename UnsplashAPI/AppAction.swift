//
//  AppAction.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

enum AppAction {
    case fetchPhotos
    case fetchPhotosSuccess([UnsplashPhoto])
    case fetchPhotosFailure(APIError)
}
