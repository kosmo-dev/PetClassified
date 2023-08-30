//
//  DetailViewControllerSpy.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import Foundation
import XCTest
@testable import PetClassified

final class DetailViewControllerSpy: DetailViewControllerProtocol {
    var displayCalled = false
    var displayErrorCalled = false
    var expectation: XCTestExpectation?

    func display(_ viewModel: PetClassified.DetailModels.ViewModel) {
        displayCalled = true
        expectation?.fulfill()
    }

    func displayError(_ errorMessage: PetClassified.DetailModels.ErrorMessage) {
        displayErrorCalled = true
        expectation?.fulfill()
    }
}
