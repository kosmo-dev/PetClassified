//
//  NetworkClient.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import Foundation

protocol NetworkClient {
    func send<T: Decodable>(request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> NetworkTask?
    func send(request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) -> NetworkTask?
}

struct DefaultNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder())
    {
        self.session = session
        self.decoder = decoder
    }

    func send<T: Decodable>(request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) -> NetworkTask? {
        return send(request: request) { result in
            switch result {
            case .success(let data):
                parse(data: data, type: type, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func send(request: NetworkRequest, completion: @escaping (Result<Data, Error>) -> Void) -> NetworkTask? {
        guard let urlRequest = make(request: request) else { return nil }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkClientError.urlSessionError))
                return
            }

            guard 200 ..< 300 ~= response.statusCode else {
                completion(.failure(NetworkClientError.httpStatusCode(response.statusCode)))
                return
            }

            if let data = data  {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(NetworkClientError.urlRequestError(error)))
            } else {
                assertionFailure("urlSession failure")
                return
            }
        }

        task.resume()

        return DefaultNetworkTask(dataTask: task)
    }

    // MARK: - Private Methods
    private func make(request: NetworkRequest) -> URLRequest? {
        guard let endpoint = request.endpoint else {
            return nil
        }

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = request.httpMethod.rawValue

        return urlRequest
    }

    private func parse<T:Decodable>(data: Data, type _: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let decoded = try decoder.decode(T.self, from: data)
            completion(.success(decoded))
        } catch {
            completion(.failure(NetworkClientError.parsingError))
        }
    }
}
