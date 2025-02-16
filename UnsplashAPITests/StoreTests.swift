//
//  StoreTests.swift
//  UnsplashAPITests
//
//  Created by Anatoliy Ostapenko on 16.02.2025.
//

import XCTest
@testable import UnsplashAPI

final class StoreTests: XCTestCase {

    func test_initialState_isEmpty() {
        // Given
        let initialState = AppState()
        let store = Store(initialState: initialState, reducer: appReducer)

        // Then
        XCTAssertEqual(store.state.photos.count, 0, "Photos should be empty initially")
        XCTAssertFalse(store.state.isLoading, "isLoading should be false initially")
        XCTAssertNil(store.state.error, "Error should be nil initially")
    }
    
    func test_dispatchFetchPhotos_setsLoadingState() {
        // Given
        let store = Store(initialState: AppState(), reducer: appReducer)

        // When
        store.dispatch(.fetchPhotos)

        // Then (after async update)
        DispatchQueue.main.async {
            XCTAssertTrue(store.state.isLoading, "isLoading should be true when fetching starts")
            XCTAssertNil(store.state.error, "Error should be nil when fetching starts")
        }
    }
    
    func test_dispatchFetchPhotosSuccess_updatesPhotos() {
        // Given
        let store = Store(initialState: AppState(isLoading: true), reducer: appReducer)

        // When
        store.dispatch(.fetchPhotosSuccess([UnsplashPhoto()]))

        // Then (after async update)
        DispatchQueue.main.async {
            XCTAssertEqual(store.state.photos.count, [UnsplashPhoto()].count, "Photos should be updated after success")
            XCTAssertFalse(store.state.isLoading, "isLoading should be false after success")
        }
    }
    
    func test_dispatchFetchPhotosFailure_setsError() {
        // Given
        let store = Store(initialState: AppState(isLoading: true), reducer: appReducer)
        let mockError = APIError.invalidURL

        // When
        store.dispatch(.fetchPhotosFailure(mockError))

        // Then (after async update)
        DispatchQueue.main.async {
            XCTAssertEqual(store.state.error, mockError, "Error should be set on failure")
            XCTAssertFalse(store.state.isLoading, "isLoading should be false after failure")
        }
    }
}
