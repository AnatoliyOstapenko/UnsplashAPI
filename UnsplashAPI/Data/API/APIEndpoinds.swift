//
//  APIEndpoinds.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

public struct APIEndpoinds {
    static var baseURL: String {
        return WebUrl.prodUrl
    }
    
    static var photosURL: String {
        return baseURL + "/photos"
    }
}
