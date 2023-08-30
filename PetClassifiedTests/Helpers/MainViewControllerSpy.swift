//
//  MainViewControllerSpy.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import Foundation
import XCTest
@testable import PetClassified

final class MainViewControllerSpy: MainViewControllerProtocol {
    var displayLoadingCalled = false
    var displayLoadedCalled = false
    var displayErrorCalled = false
    var expectation: XCTestExpectation?

    func display(viewModel: PetClassified.MainModels.ViewModel) {
        displayLoadedCalled = true
        expectation?.fulfill()
    }

    func displayLoading(viewModel: PetClassified.MainModels.ViewModel) {
        displayLoadingCalled = true
        expectation?.fulfill()
    }

    func updateCellWithImage(viewModel: PetClassified.MainModels.ImageViewModel) {}

    func displayError(error: PetClassified.MainModels.ErrorMessage) {
        displayErrorCalled = true
        expectation?.fulfill()
    }
}
