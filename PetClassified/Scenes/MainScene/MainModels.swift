//
//  MainModels.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import UIKit

enum MainModels {
    struct Request {
        let imageURL: String
    }

    struct Response {
        let state: MainViewState
    }

    struct ImageResponse {
        let images: [String: UIImage]
        let index: Int
    }

    struct ViewModel {
        let advertisements: [Advertisement]
    }

    struct ImageViewModel {
        let images: [String: UIImage]
        let indexPaths: [IndexPath]
    }

    struct ErrorMessage {
        let message: String
    }
}
