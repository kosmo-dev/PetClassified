//
//  DetailViewState.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import Foundation

enum DetailViewState {
    case loading
    case display(adv: DetailAdv)
    case error(Error)
}
