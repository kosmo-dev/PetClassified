//
//  DetailPresenter.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

protocol DetailPresenterProtocol {
    var viewController: DetailViewControllerProtocol? { get set }
    func stateChanged(to state: DetailModels.Response)
}

final class DetailPresenter: DetailPresenterProtocol {
    weak var viewController: DetailViewControllerProtocol?

    func stateChanged(to state: DetailModels.Response) {
        DispatchQueue.main.async {
            switch state.state {
            case .loading(emptyAdv: let adv, image: let image):
                let imageToPresent = image ?? UIImage(named: "ImagePlaceholder") ?? UIImage()
                self.viewController?.display(DetailModels.ViewModel(advertisement: adv, image: imageToPresent))
            case .display(adv: let adv, image: let image):
                let imageToPresent = image ?? UIImage(named: "ImagePlaceholder") ?? UIImage()
                self.viewController?.display(DetailModels.ViewModel(advertisement: adv, image: imageToPresent))
            case .error(let error):
                self.viewController?.displayError(DetailModels.ErrorMessage(message: "Error"))
            }
        }
    }
}
