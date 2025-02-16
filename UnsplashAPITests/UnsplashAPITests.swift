//
//  UnsplashAPITests.swift
//  UnsplashAPITests
//
//  Created by Anatoliy Ostapenko on 16.02.2025.
//

import XCTest
import Combine
@testable import UnsplashAPI

final class APIServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []
    var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
    }

    override func tearDown() {
        mockAPIService = nil
        cancellables.removeAll()
        super.tearDown()
    }

    // Test successful API response
    func test_fetchPhotos_successfulResponse() {
        // Given
        let expectedPhotos = [UnsplashPhoto()]
        mockAPIService.result = .success(expectedPhotos)

        let expectation = XCTestExpectation(description: "Fetch photos successfully")

        // When
        mockAPIService.fetchPhotos()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { photos in
                // Then
                XCTAssertEqual(photos.count, expectedPhotos.count, "Should return correct number of photos")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    // Test API Failure - offline
    func test_fetchPhotos_failureResponse() {
        // Given
        mockAPIService.result = .failure(.offline)

        let expectation = XCTestExpectation(description: "Fetch photos fails due to network error")

        // When
        mockAPIService.fetchPhotos()
            .sink(receiveCompletion: { completion in
                // Then
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, APIError.offline, "Should return offline error")
                    expectation.fulfill()
                } else {
                    XCTFail("Expected failure but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
