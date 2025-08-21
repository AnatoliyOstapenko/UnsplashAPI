//
//  APIEndpoinds.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

public struct APIEndpoinds {
    // Base url
    static private let baseURL = Environment.baseUrl
    
    // Endpoints
    static var photosURL: String {
        return baseURL + "/photos"
    }
}
