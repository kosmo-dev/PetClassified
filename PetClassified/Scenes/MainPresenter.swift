//
//  MainPresenter.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import Foundation

protocol MainPresenterProtocol {
    var viewController: MainViewControllerProtocol? { get set }
    func present(advs: [Advertisement])
}

final class MainPresenter: MainPresenterProtocol {
    weak var viewController: MainViewControllerProtocol?

    func present(advs: [Advertisement]) {
        viewController?.display(advs: advs)
    }
}
