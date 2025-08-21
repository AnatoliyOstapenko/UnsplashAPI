//
//  API.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation
import Alamofire

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
    
    var encoding: ParameterEncoding {
        switch self {
        case .photos:
            return URLEncoding.default
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .photos:
            return .get
        }
    }
}
