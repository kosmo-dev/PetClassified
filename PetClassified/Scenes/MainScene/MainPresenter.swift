//
//  MainPresenter.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

protocol MainPresenterProtocol {
    var viewController: MainViewControllerProtocol? { get set }
    func stateChanged(to state: MainViewState)
    func updateImage(images: [String: UIImage], index: Int)
}

final class MainPresenter: MainPresenterProtocol {
    weak var viewController: MainViewControllerProtocol?

    private let loadingAdvs: [Advertisement] = [
        Advertisement(id: "0", title: "", price: "", location: "", imageURL: "", createdDate: ""),
        Advertisement(id: "1", title: "", price: "", location: "", imageURL: "", createdDate: ""),
        Advertisement(id: "2", title: "", price: "", location: "", imageURL: "", createdDate: ""),
        Advertisement(id: "3", title: "", price: "", location: "", imageURL: "", createdDate: ""),
        Advertisement(id: "4", title: "", price: "", location: "", imageURL: "", createdDate: ""),
        Advertisement(id: "5", title: "", price: "", location: "", imageURL: "", createdDate: ""),
    ]

    func stateChanged(to state: MainViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch state {
            case .loading:
                self.viewController?.displayLoading(emptyAdvs: loadingAdvs)
            case .display(let advs):
                self.viewController?.display(advs: advs)
            case .error(let error):
                self.viewController?.displayError(message: error.localizedDescription)
            }
        }
    }

    func updateImage(images: [String : UIImage], index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.updateCellWithImage(images, for: [IndexPath(row: index, section: 1)])
        }
    }
}
