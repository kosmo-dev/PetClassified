//
//  DetailModels.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 28.08.2023.
//

import UIKit

enum DetailModels {
    struct Request {
        let advertisement: Advertisement
        let image: UIImage?
    }

    struct Response {
        let state: DetailViewState
    }

    struct ViewModel {
        let advertisement: DetailAdv
        let image: UIImage
    }

    struct ErrorMessage {
        let message: String
    }
}
