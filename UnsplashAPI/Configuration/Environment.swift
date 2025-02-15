//
//  Environment.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

public enum Environment {
    enum Keys {
        static let apyKey = "API_KEY"
        static let baseUrl = "BASE_URL"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    static let baseUrl: String = {
        guard let baseUrlString = Environment.infoDictionary[Keys.baseUrl] as? String else {
            fatalError("Failed to get Base URL from plist")
        }
        return baseUrlString
    }()

    static let apyKey: String = {
        guard let apiKeyString = Environment.infoDictionary[Keys.apyKey] as? String else {
            fatalError("Failed to get API token from plist")
        }
        return apiKeyString
    }()
}
