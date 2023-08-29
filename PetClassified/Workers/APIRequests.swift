//
//  APIRequests.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import Foundation

struct AdvertisementRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")
}

struct DetailRequest: NetworkRequest {
    var id: String
    private let path: String = "https://www.avito.st/s/interns-ios/details/"
    var endpoint: URL? {
        let string = "\(path)\(id).json"
        return URL(string: string)
    }
}

struct ImageRequest: NetworkRequest {
    var endpoint: URL?
}
