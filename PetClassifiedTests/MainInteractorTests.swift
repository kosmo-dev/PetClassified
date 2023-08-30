//
//  PetClassifiedTests.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import XCTest
@testable import PetClassified

final class MainInteractorTests: XCTestCase {

    func testFirstTimeCallFetchDataChangesStateToLoading() {
        // Given
        let networkWorker = NetworkWorkerSuccessStub()
        let presenterSpy = MainPresenterSpy()
        let interactor = MainInteractor(networkWorker: networkWorker)
        interactor.presenter = presenterSpy

        // When
        interactor.fetchData()

        // Then
        XCTAssertTrue(presenterSpy.stateIsLoading)
    }

    func testSuccessFetchDataChangesStateToLoaded() {
        // Given
        let networkWorker = NetworkWorkerSuccessStub()
        let presenterSpy = MainPresenterSpy()
        let interactor = MainInteractor(networkWorker: networkWorker)
        interactor.presenter = presenterSpy

        // When
        interactor.fetchData()

        // Then
        XCTAssertTrue(presenterSpy.stateIsLoaded)
    }

    func testFailureFetchDataChangesStateToError() {
        // Given
        let networkWorker = NetworkWorkerFailureStub()
        let presenterSpy = MainPresenterSpy()
        let interactor = MainInteractor(networkWorker: networkWorker)
        interactor.presenter = presenterSpy

        // When
        interactor.fetchData()

        // Then
        XCTAssertTrue(presenterSpy.stateIsError)
    }

    func testSuccessFetchDataResponseWithDataToPresenter() {
        // Given
        let networkWorker = NetworkWorkerSuccessStub()
        let presenterSpy = MainPresenterSpy()
        let interactor = MainInteractor(networkWorker: networkWorker)
        interactor.presenter = presenterSpy

        // When
        interactor.fetchData()
        let mockAdvertisementId = AdvertisementsMock.advertisements.advertisements[0].id

        // Then
        XCTAssertEqual(presenterSpy.advertisements![0].id, mockAdvertisementId)
    }
}
