//
//  UnsplashPhoto.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation

struct UnsplashPhoto: Codable, Identifiable {
    let id: String
    let description: String?
    let urls: UnsplashPhotoURLs
    let user: UnsplashUser

    init(id: String = UUID().uuidString,
         description: String? = "A sample image",
         urls: UnsplashPhotoURLs = UnsplashPhotoURLs.mock,
         user: UnsplashUser = UnsplashUser.mock) {
        self.id = id
        self.description = description
        self.urls = urls
        self.user = user
    }
}

struct UnsplashPhotoURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

extension UnsplashPhotoURLs {
    static let mock = UnsplashPhotoURLs(
        raw: "https://images.unsplash.com/photo-1686282329177-ae415627885c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        full: "https://images.unsplash.com/photo-1686282329177-ae415627885c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        regular: "https://images.unsplash.com/photo-1686282329177-ae415627885c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        small: "https://images.unsplash.com/photo-1686282329177-ae415627885c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
        thumb: "https://images.unsplash.com/photo-1686282329177-ae415627885c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80"
    )
}

struct UnsplashUser: Codable {
    let id: String
    let username: String
    let name: String
    let profileImage: UnsplashProfileImage
    
    private enum CodingKeys: String, CodingKey {
        case id, username, name
        case profileImage = "profile_image"
    }
}

extension UnsplashUser {
    static let mock = UnsplashUser(
        id: "sampleId",
        username: "sampleUser",
        name: "Sample User",
        profileImage: UnsplashProfileImage.mock
    )
}

struct UnsplashProfileImage: Codable {
    let small: String
    let medium: String
    let large: String

    static let mock = UnsplashProfileImage(
        small: "https://images.unsplash.com/profile_placeholder.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=32&h=32",
        medium: "https://images.unsplash.com/profile_placeholder.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=64&h=64",
        large: "https://images.unsplash.com/profile_placeholder.jpg?ixlib=rb-4.0.3&crop=faces&fit=crop&w=128&h=128"
    )
}

