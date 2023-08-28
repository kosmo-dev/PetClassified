//
//  DetailInteractor.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

protocol DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol? { get set}
    func fetchData(_ request: DetailModels.Request)
}

final class DetailInteractor: DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol?

    private let networkWorker: NetworkWorkerProtocol
    private var currentState: DetailViewState?
    private var image: UIImage?

    init() {
        networkWorker = NetworkWorker()
    }

    func fetchData(_ request: DetailModels.Request) {
        responseWithPrefetchedData(request)
        networkWorker.send(request: DetailRequest(id: request.advertisement.id), type: DetailAdv.self, id: request.advertisement.id) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let detailAdv):
                self.currentState = .display(adv: detailAdv)
            case .failure(let error):
                self.currentState = .error(error)
            }
            if let state = self.currentState {
                self.presenter?.stateChanged(to: DetailModels.Response(state: state, image: image))
            }
        }
    }

    func responseWithPrefetchedData(_ request: DetailModels.Request) {
        image = request.image
        if currentState == nil {
            let adv = request.advertisement
            let prefetchedAdv = DetailAdv(id: adv.id, title: adv.title, price: adv.price, location: adv.location, imageURL: adv.imageURL, createdDate: adv.createdDate, description: "", email: "", phoneNumber: "", address: "")
            currentState = .loading(emptyAdv: prefetchedAdv)
            if let currentState {
                presenter?.stateChanged(to: DetailModels.Response(state: currentState, image: image))
            }
        }
        if image == nil {
            let url = URL(string: request.advertisement.imageURL)
            networkWorker.sendImageRequest(request: ImageRequest(endpoint: url), id: request.advertisement.imageURL) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let image):
                    self.image = image
                    if let currentState {
                        presenter?.stateChanged(to: DetailModels.Response(state: currentState, image: image))
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
