//
//  AppReducerTests.swift
//  UnsplashAPITests
//
//  Created by Anatoliy Ostapenko on 16.02.2025.
//

import XCTest
@testable import UnsplashAPI

final class AppReducerTests: XCTestCase {
    
    func test_fetchPhotosAction_setsLoadingState() {
        // Given
        let initialState = AppState()
        
        // When
        let newState = appReducer(state: initialState, action: .fetchPhotos)
        
        // Then
        XCTAssertTrue(newState.isLoading, "isLoading should be true when fetching photos")
        XCTAssertNil(newState.error, "error should be nil when starting fetch")
    }
    
    func test_fetchPhotosSuccess_updatesPhotosAndStopsLoading() {
        // Given
        let initialState = AppState(isLoading: true)
        let mockPhotos = [UnsplashPhoto()]

        // When
        let newState = appReducer(state: initialState, action: .fetchPhotosSuccess(mockPhotos))

        // Then
        XCTAssertEqual(newState.photos.count, mockPhotos.count, "Photos array should be updated")
        XCTAssertFalse(newState.isLoading, "isLoading should be false after successful fetch")
    }
    
    func test_fetchPhotosFailure_setsErrorAndStopsLoading() {
        // Given
        let initialState = AppState(isLoading: true) // Simulate loading state
        let mockError = APIError.invalidURL

        // When
        let newState = appReducer(state: initialState, action: .fetchPhotosFailure(mockError))

        // Then
        XCTAssertEqual(newState.error, mockError, "Error should be set on failure")
        XCTAssertFalse(newState.isLoading, "isLoading should be false after failure")
    }
}


