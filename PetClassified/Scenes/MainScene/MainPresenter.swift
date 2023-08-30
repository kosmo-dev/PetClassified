//
//  MainPresenter.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

protocol MainPresenterProtocol {
    var viewController: MainViewControllerProtocol? { get set }
    func stateChanged(response: MainModels.Response)
    func updateImage(response: MainModels.ImageResponse)
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

    func stateChanged(response: MainModels.Response) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            switch response.state {
            case .loading:
                self.viewController?.displayLoading(viewModel: MainModels.ViewModel(advertisements: loadingAdvs))
            case .display(let advs):
                self.viewController?.display(viewModel: MainModels.ViewModel(advertisements: advs))
            case .error(let error):
                self.viewController?.displayError(error: MainModels.ErrorMessage(message: error.localizedDescription))
            }
        }
    }

    func updateImage(response: MainModels.ImageResponse) {
        DispatchQueue.main.async { [weak self] in
            let viewModel = MainModels.ImageViewModel(images: response.images, indexPaths: [IndexPath(item: response.index, section: 1)])
            self?.viewController?.updateCellWithImage(viewModel: viewModel)
        }
    }
}
