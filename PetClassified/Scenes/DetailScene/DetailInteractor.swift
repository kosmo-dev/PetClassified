//
//  DetailInteractor.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import Foundation

protocol DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol? { get set}
    func fetchData(for id: String)
}

final class DetailInteractor: DetailInteractorProtocol {
    var presenter: DetailPresenterProtocol?

    private let networkWorker: NetworkWorkerProtocol
    private var currentState: DetailViewState?

    init() {
        networkWorker = NetworkWorker()
    }

    func fetchData(for id: String) {
        networkWorker.send(request: DetailRequest(id: id), type: DetailAdv.self, id: id) { [weak self] result in
            switch result {
            case .success(let detailAdv):
                self?.currentState = .display(adv: detailAdv)
            case .failure(let error):
                self?.currentState = .error(error)
            }
            if let state = self?.currentState {
                self?.presenter?.stateChanged(to: state)
            }
        }
    }
}
