//
//  PresenterSpy.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import Foundation
@testable import PetClassified

final class MainPresenterSpy: MainPresenterProtocol {
    var viewController: PetClassified.MainViewControllerProtocol?

    var stateIsLoading = false
    var stateIsLoaded = false
    var stateIsError = false
    var advertisements: [Advertisement]?

    func stateChanged(response: PetClassified.MainModels.Response) {
        switch response.state {
        case .loading:
            stateIsLoading = true
        case .display(advs: let advs):
            stateIsLoaded = true
            advertisements = advs
        case .error(_):
            stateIsError = true
        }
    }

    func updateImage(response: PetClassified.MainModels.ImageResponse) {
        
    }
}
