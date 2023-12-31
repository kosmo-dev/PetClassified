//
//  DetailViewState.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

enum DetailViewState {
    case loading(emptyAdv: DetailAdv)
    case display(adv: DetailAdv)
    case error(Error)
}
