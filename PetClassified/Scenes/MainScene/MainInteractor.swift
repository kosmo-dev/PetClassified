//
//  MainInteractor.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

protocol MainInteractorProtocol {
    var presenter: MainPresenterProtocol? { get set }
    func fetchData()
    func fetchImage(request: MainModels.Request)
    func cancelAllLoadTasks()
}

final class MainInteractor: MainInteractorProtocol {
    // MARK: - Public Properties
    var presenter: MainPresenterProtocol?

    // MARK: - Private Properties
    private let networkWorker: NetworkWorkerProtocol

    private var currentState: MainViewState?
    private var advs: [Advertisement] = []
    private var images: [String: UIImage] = [:]

    // MARK: - Initializator
    init(networkWorker: NetworkWorkerProtocol) {
        self.networkWorker = networkWorker
    }

    // MARK: - Public Methods
    func fetchData() {
        if currentState == nil {
            currentState = .loading
            if let currentState {
                presenter?.stateChanged(response: MainModels.Response(state: currentState))
            }
        }
        networkWorker.send(request: AdvertisementRequest(), type: Advertisements.self, id: UUID().uuidString) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.advs = data.advertisements
                currentState = .display(advs: data.advertisements)
            case .failure(let error):
                currentState = .error(error)
            }
            if let currentState {
                self.presenter?.stateChanged(response: MainModels.Response(state: currentState))
            }
        }
    }

    func fetchImage(request: MainModels.Request) {
        guard images[request.imageURL] == nil, let state = currentState else { return }
        switch state {
        case .display(_):
            let url = URL(string: request.imageURL)
            networkWorker.sendImageRequest(request: ImageRequest(endpoint: url), id: request.imageURL) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let image):
                    self.images[request.imageURL] = image
                    if let index = self.advs.firstIndex(where: { $0.imageURL == request.imageURL }) {
                        let response = MainModels.ImageResponse(images: self.images, index: index)
                        self.presenter?.updateImage(response: response)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        default:
            return
        }
    }

    func cancelAllLoadTasks() {
        networkWorker.cancelAllLoadTasks()
    }
}
