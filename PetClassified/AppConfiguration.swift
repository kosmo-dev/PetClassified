//
//  AppConfiguration.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

final class AppConfiguration {
    var mainViewController: MainViewControllerProtocol
    var mainInteractor: MainInteractorProtocol
    var mainPresenter: MainPresenterProtocol

    init() {
        mainInteractor = MainInteractor()
        mainPresenter = MainPresenter()
        mainViewController = MainViewController(interactor: mainInteractor)
        mainInteractor.presenter = mainPresenter
        mainPresenter.viewController = mainViewController
    }
}
