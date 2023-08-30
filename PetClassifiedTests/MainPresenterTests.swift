//
//  MainPresenterTests.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import XCTest
@testable import PetClassified

final class MainPresenterTests: XCTestCase {

    func testPresenterCallLoadingWhenReceiveStateLoading() {
        // Given
        let expectation = self.expectation(description: "wait for async operation")
        let presenter = MainPresenter()
        let viewController = MainViewControllerSpy()
        viewController.expectation = expectation
        presenter.viewController = viewController

        // When
        presenter.stateChanged(response: MainModels.Response(state: .loading))

        // Wait
        waitForExpectations(timeout: 1) { error in
            if let error {
                XCTFail()
            }
            // Then
            XCTAssertTrue(viewController.displayLoadingCalled)
        }
    }

    func testPresenterCallLoadedWhenReceiveStateLoaded() {
        // Given
        let expectation = self.expectation(description: "wait for async operation")
        let presenter = MainPresenter()
        let viewController = MainViewControllerSpy()
        viewController.expectation = expectation
        presenter.viewController = viewController

        // When
        presenter.stateChanged(response: MainModels.Response(state: .display(advs: AdvertisementsMock.advertisements.advertisements)))

        // Wait
        waitForExpectations(timeout: 1) { error in
            if let error {
                XCTFail()
            }
            // Then
            XCTAssertTrue(viewController.displayLoadedCalled)
        }
    }

    func testPresenterCallErrorWhenReceiveStateError() {
        // Given
        let expectation = self.expectation(description: "wait for async operation")
        let presenter = MainPresenter()
        let viewController = MainViewControllerSpy()
        viewController.expectation = expectation
        presenter.viewController = viewController

        // When
        presenter.stateChanged(response: MainModels.Response(state: .error(NetworkClientError.parsingError)))

        // Wait
        waitForExpectations(timeout: 1) { error in
            if let error {
                XCTFail()
            }
            // Then
            XCTAssertTrue(viewController.displayErrorCalled)
        }
    }
}
