//
//  AdvertisementsMock.swift
//  PetClassifiedTests
//
//  Created by Вадим Кузьмин on 30.08.2023.
//

import Foundation
@testable import PetClassified

struct AdvertisementsMock {
    static let advertisements = Advertisements(advertisements: [Advertisement(id: "1", title: "adv", price: "5", location: "", imageURL: "", createdDate: "")])
}
