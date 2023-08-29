//
//  MainViewState.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import Foundation

enum MainViewState {
    case loading
    case display(advs: [Advertisement])
    case error(Error)
}
