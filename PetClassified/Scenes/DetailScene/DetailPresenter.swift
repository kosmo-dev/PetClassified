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
        let imageToPresent = state.image ?? UIImage(named: "ImagePlaceholder") ?? UIImage()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch state.state {
            case .loading(emptyAdv: let adv):
                self.viewController?.display(DetailModels.ViewModel(advertisement: adv, image: imageToPresent, isLoaded: false))
            case .display(adv: let adv):
                self.viewController?.display(DetailModels.ViewModel(advertisement: adv, image: imageToPresent, isLoaded: true))
            case .error(let error):
                self.viewController?.displayError(DetailModels.ErrorMessage(message: error.localizedDescription))
            }
        }
    }
}
