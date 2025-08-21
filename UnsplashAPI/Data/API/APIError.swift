//
//  APIError.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

enum APIError: Error, LocalizedError, Identifiable {
    var id: String { UUID().uuidString }
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case offline
    case unknown(Error)
    
    var errorDescription: String {
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
}

extension APIError: Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL),
            (.invalidResponse, .invalidResponse),
            (.offline, .offline):
            return true
        case (.requestFailed, .requestFailed),
            (.decodingError, .decodingError),
            (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
