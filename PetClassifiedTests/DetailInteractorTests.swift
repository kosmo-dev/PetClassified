//
//  DetailInteractorTests.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import XCTest
@testable import PetClassified

final class DetailInteractorTests: XCTestCase {

    func testFirstTimeCallFetchDataChangesStateToLoading() {
        // Given
        let networkWorker = DetailNetworkWorkerEmptyStub()
        let interactor = DetailInteractor(networkWorker: networkWorker)
        let presenter = DetailPresenterSpy()
        interactor.presenter = presenter

        // When
        interactor.fetchData(DetailModels.Request(advertisement: AdvertisementsMock.advertisements.advertisements[0], image: nil))

        // Then
        XCTAssertTrue(presenter.stateIsLoading)
    }

    func testSuccessFetchDataChangesStateToLoaded() {
        // Given
        let networkWorker = DetailNetworkWorkerSuccessStub()
        let interactor = DetailInteractor(networkWorker: networkWorker)
        let presenter = DetailPresenterSpy()
        interactor.presenter = presenter

        // When
        interactor.fetchData(DetailModels.Request(advertisement: AdvertisementsMock.advertisements.advertisements[0], image: nil))

        // Then
        XCTAssertTrue(presenter.stateIsLoaded)
    }

    func testFailureFetchDataChangesStateToError() {
        // Given
        let networkWorker = DetailNetworkWorkerFailureStub()
        let interactor = DetailInteractor(networkWorker: networkWorker)
        let presenter = DetailPresenterSpy()
        interactor.presenter = presenter

        // When
        interactor.fetchData(DetailModels.Request(advertisement: AdvertisementsMock.advertisements.advertisements[0], image: nil))

        // Then
        XCTAssertTrue(presenter.stateIsError)
    }

    func testSuccessFetchDataResponseWithDataToPresenter() {
        // Given
        let networkWorker = DetailNetworkWorkerSuccessStub()
        let interactor = DetailInteractor(networkWorker: networkWorker)
        let presenter = DetailPresenterSpy()
        interactor.presenter = presenter

        // When
        let mock = AdvertisementsMock.advertisements.advertisements[0]
        interactor.fetchData(DetailModels.Request(advertisement: mock, image: nil))

        // Then
        XCTAssertEqual(presenter.advToDispay?.id, mock.id)
    }

}
