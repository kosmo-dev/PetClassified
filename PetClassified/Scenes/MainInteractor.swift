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
    var presenter: MainPresenterProtocol?
    let networkWorker: NetworkWorkerProtocol

    var advs: [Advertisement] = []
    var images: [String: UIImage] = [:]

    init() {
        networkWorker = NetworkWorker()
    }

    func fetchData() {
        networkWorker.send(request: AdvertisementRequest(), type: Advertisements.self, id: UUID().uuidString) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.advs = data.advertisements
                self.presenter?.present(advs: data.advertisements)
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchImage(for imageURL: String) {
        guard images[imageURL] == nil else { return }
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
    }

    func cancelAllLoadTasks() {
        networkWorker.cancelAllLoadTasks()
    }
}
