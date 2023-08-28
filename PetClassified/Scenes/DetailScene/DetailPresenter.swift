//
//  DetailPresenter.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import Foundation

protocol DetailPresenterProtocol {
    var viewController: DetailViewControllerProtocol? { get set }
    func stateChanged(to state: DetailViewState)
}

final class DetailPresenter: DetailPresenterProtocol {
    weak var viewController: DetailViewControllerProtocol?

    func stateChanged(to state: DetailViewState) {
        DispatchQueue.main.async {
            switch state {
            case .loading:
                print("Loading")
            case .display(let adv):
                self.viewController?.display(adv: adv)
            case .error(let error):
                print(error)
            }
        }
    }
}
