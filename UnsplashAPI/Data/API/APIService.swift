//
//  APIService.swift
//  UnsplashAPI
//
//  Created by Anatoliy Ostapenko on 15.02.2025.
//

import Foundation
import Alamofire
import Combine

protocol APIServiceProtocol {
    func fetchPhotos() -> AnyPublisher<[UnsplashPhoto], APIError>
}

class APIService: APIServiceProtocol {
    func fetchPhotos() -> AnyPublisher<[UnsplashPhoto], APIError> {
        return request(endpoint: .photos)
    }
}

extension APIService {
    private func request<T: Decodable>(endpoint: API, method: HTTPMethod = .get) -> AnyPublisher<T, APIError> {

        return AF.request(
            endpoint.url,
            method: method,
            parameters: endpoint.parameters,
            encoding: URLEncoding.default
        )
        .validate()
        .publishDecodable(type: T.self)
        .tryMap { response -> T in
            if let error = response.error {
                if let afError = error.asAFError {
                    if afError.isSessionTaskError,
                       let nsError = afError.underlyingError as? NSError,
                       nsError.code == NSURLErrorNotConnectedToInternet {
                        throw APIError.offline
                    }
                }
                throw APIError.requestFailed(error)
            }

            guard let value = response.value else {
                throw APIError.decodingError(response.error ?? AFError.responseValidationFailed(reason: .dataFileNil))
            }
            return value
        }
        .mapError { error -> APIError in
            Logger.log("Alamofire error: \(error)", level: .error)
            if let apiError = error as? APIError {
                return apiError
            }
            return .unknown(error)
        }
        .eraseToAnyPublisher()
    }
}
