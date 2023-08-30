//
//  NetworkWorkerStub.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import UIKit
@testable import PetClassified

final class NetworkWorkerSuccessStub: NetworkWorkerProtocol {
    func send<T>(request: PetClassified.NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let advs = AdvertisementsMock.advertisements
        completion(.success(advs as! T))
    }

    func sendImageRequest(request: PetClassified.NetworkRequest, id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {

    }

    func cancelAllLoadTasks() {}
}

final class NetworkWorkerFailureStub: NetworkWorkerProtocol {
    func send<T>(request: PetClassified.NetworkRequest, type: T.Type, id: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(.failure(NetworkClientError.urlSessionError))
    }

    func sendImageRequest(request: PetClassified.NetworkRequest, id: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
    }

    func cancelAllLoadTasks() {}
}
