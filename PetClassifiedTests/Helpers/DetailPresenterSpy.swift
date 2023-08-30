//
//  DetailPresenterSpy.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import Foundation
import XCTest
@testable import PetClassified

final class DetailPresenterSpy: DetailPresenterProtocol {
    var viewController: PetClassified.DetailViewControllerProtocol?

    var stateIsLoading = false
    var stateIsLoaded = false
    var stateIsError = false

    var advToDispay: DetailAdv?

    func stateChanged(to state: PetClassified.DetailModels.Response) {
        print("state.state", state.state)
        switch state.state {
        case .display(adv: let detailAdv):
            stateIsLoaded = true
            advToDispay = detailAdv
        case .loading(emptyAdv: _):
            stateIsLoading = true
        case .error(_):
            stateIsError = true
        }
    }
}
