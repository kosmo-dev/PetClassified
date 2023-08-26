//
//  MainPresenter.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

protocol MainPresenterProtocol {
    var viewController: MainViewControllerProtocol? { get set }
    func present(advs: [Advertisement])
    func updateImage(images: [String: UIImage], index: Int)
}

final class MainPresenter: MainPresenterProtocol {
    weak var viewController: MainViewControllerProtocol?

    func present(advs: [Advertisement]) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.display(advs: advs)
        }
    }

    func updateImage(images: [String : UIImage], index: Int) {
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.updateCellWithImage(images, for: [IndexPath(row: index, section: 0)])
        }
    }
}
