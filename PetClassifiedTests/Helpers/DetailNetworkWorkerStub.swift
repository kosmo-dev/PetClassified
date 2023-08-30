//
//  DetailNetworkWorkerStub.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import UIKit
@testable import PetClassified

final class DetailNetworkWorkerSuccessStub: NetworkWorkerProtocol {
    func send<T>(request: PetClassified.NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let adv = DetailAdvMock.detailAdv
        completion(.success(adv as! T))
    }

    func sendImageRequest(request: PetClassified.NetworkRequest, id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {}

    func cancelAllLoadTasks() {}
}

final class DetailNetworkWorkerFailureStub: NetworkWorkerProtocol {
    func send<T>(request: PetClassified.NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let adv = DetailAdvMock.detailAdv
        completion(.failure(NetworkClientError.parsingError))
    }

    func sendImageRequest(request: PetClassified.NetworkRequest, id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {}

    func cancelAllLoadTasks() {}
}

final class DetailNetworkWorkerEmptyStub: NetworkWorkerProtocol {
    func send<T>(request: PetClassified.NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {}

    func sendImageRequest(request: PetClassified.NetworkRequest, id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {}

    func cancelAllLoadTasks() {}
}
