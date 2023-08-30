//
//  DetailPresenterTests.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import XCTest
@testable import PetClassified

final class DetailPresenterTests: XCTestCase {

    func testPresenterCallDisplayWhenReceiveStateLoaded() {
        // Given
        let presenter = DetailPresenter()
        let viewController = DetailViewControllerSpy()
        presenter.viewController = viewController
        let expectation = expectation(description: "wait for async operation")
        viewController.expectation = expectation

        // When
        let state = DetailViewState.display(adv: DetailAdvMock.detailAdv)
        presenter.stateChanged(to: DetailModels.Response(state: state, image: nil))

        waitForExpectations(timeout: 1) { error in
            if let error {
                XCTFail()
            }
            XCTAssertTrue(viewController.displayCalled)
        }
    }

    func testPresenterCallErrorWhenReceiveStateError() {
        // Given
        let presenter = DetailPresenter()
        let viewController = DetailViewControllerSpy()
        presenter.viewController = viewController
        let expectation = expectation(description: "wait for async operation")
        viewController.expectation = expectation

        // When
        let state = DetailViewState.error(NetworkClientError.parsingError)
        presenter.stateChanged(to: DetailModels.Response(state: state, image: nil))

        waitForExpectations(timeout: 1) { error in
            if let error {
                XCTFail()
            }
            XCTAssertTrue(viewController.displayErrorCalled)
        }

    }
}
