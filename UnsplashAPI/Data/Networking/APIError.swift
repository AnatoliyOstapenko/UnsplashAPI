//
//  APIError.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

enum APIError: Error, LocalizedError, Equatable {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case offline
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL, .invalidResponse:
            return "Something went wrong, try again later"
        case .requestFailed(let error):
            return "An request error occurred: \(error.localizedDescription)"
        case .decodingError(let error):
            return "An decoding error occurred: \(error.localizedDescription)"
        case .offline:
            return "You are offline. Please, enable your Wi-Fi or connect using cellular data."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
            switch (lhs, rhs) {
            case (.invalidURL, .invalidURL):
                return true
            case (.requestFailed, .requestFailed):
                return true
            case (.invalidResponse, .invalidResponse):
                return true
            case (.decodingError, .decodingError):
                return true
            case (.offline, .offline):
                return true
            default:
                return false
            }
        }
}
