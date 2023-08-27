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
    func fetchImage(for imageURL: String)
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
    init() {
        networkWorker = NetworkWorker()
    }

    // MARK: - Public Methods
    func fetchData() {
        if currentState == nil {
            currentState = .loading
            if let currentState {
                presenter?.stateChanged(to: currentState)
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
                self.presenter?.stateChanged(to: currentState)
            }
        }
    }

    func fetchImage(for imageURL: String) {
        guard images[imageURL] == nil, let state = currentState else { return }
        switch state {
        case .display(_):
            let url = URL(string: imageURL)
            networkWorker.sendImageRequest(request: ImageRequest(endpoint: url), id: imageURL) { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let image):
                    self.images[imageURL] = image
                    if let index = self.advs.firstIndex(where: { $0.imageURL == imageURL }) {
                        self.presenter?.updateImage(images: self.images, index: index)
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
