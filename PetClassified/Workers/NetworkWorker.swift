//
//  NetworkWorker.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

protocol NetworkWorkerProtocol {
    func send<T: Decodable>(request: NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void)
    func sendImageRequest(request: NetworkRequest, id: String, completion: @escaping (Result<UIImage, Error>) -> Void)
    func cancelAllLoadTasks()
}

final class NetworkWorker: NetworkWorkerProtocol {
    // MARK: - Private Properties
    private var networkClient: NetworkClient
    private var onGoingTasks: [String: NetworkTask] = [:]
    private let decoder = JSONDecoder()

    // MARK: - Initializers
    init() {
        self.networkClient = DefaultNetworkClient()
    }

    // MARK: - Public Methods
    func send<T: Decodable>(request: NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard onGoingTasks[id] == nil else { return }
        let task = networkClient.send(request: request, type: type) {[weak self] result in
            self?.onGoingTasks[id] = nil
            completion(result)
        }
        if let task {
            onGoingTasks[id] = task
        }
    }

    func sendImageRequest(request: NetworkRequest, id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard onGoingTasks[id] == nil else { return }
        let task = networkClient.send(request: request) { [weak self] result in
            self?.onGoingTasks[id] = nil
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NetworkClientError.parsingError))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        if let task {
            onGoingTasks[id] = task
        }
    }

    func cancelAllLoadTasks() {
        onGoingTasks.forEach { $0.value.cancel() }
    }
}
