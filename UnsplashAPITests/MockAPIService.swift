//
//  MockAPIService.swift
//  UnsplashAPITests
//
//  Created by Anatoliy Ostapenko on 16.02.2025.
//

import Combine
@testable import UnsplashAPI

class MockAPIService: APIServiceProtocol {
    var result: Result<[UnsplashPhoto], APIError> = .success([])

    func fetchPhotos() -> AnyPublisher<[UnsplashPhoto], APIError> {
        return Future { promise in
            promise(self.result)
        }
        .eraseToAnyPublisher()
    }
}
