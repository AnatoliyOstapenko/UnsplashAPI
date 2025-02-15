//
//  API.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

enum API {
    case photos
    
    var url: String {
        switch self {
        case .photos:
            return APIEndpoinds.photosURL
        }
    }

    var parameters: [String: Any] {
        switch self {
        case .photos:
            return ["client_id": Environment.apyKey]
        }
    }
}
