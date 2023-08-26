//
//  MainInteractor.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import Foundation

protocol MainInteractorProtocol {
    var presenter: MainPresenterProtocol? { get set }
    func fetchData()
}

final class MainInteractor: MainInteractorProtocol {
    var presenter: MainPresenterProtocol?

    private let mockAdvs: [Advertisement] = [
        Advertisement(id: "1", title: "iPhone 11", price: "55 000 ₽", location: "Москва 1", imageURL: "", createdDate: "2023-08-16"),
        Advertisement(id: "2", title: "iPhone 12", price: "65 000 ₽", location: "Москва 2", imageURL: "", createdDate: "2023-08-17"),
        Advertisement(id: "3", title: "iPhone 13", price: "75 000 ₽", location: "Москва 3", imageURL: "", createdDate: "2023-08-18"),
        Advertisement(id: "4", title: "iPhone 14", price: "85 000 ₽", location: "Москва 4", imageURL: "", createdDate: "2023-08-19"),
        Advertisement(id: "5", title: "iPhone 13 Pro", price: "95 000 ₽", location: "Москва 5", imageURL: "", createdDate: "2023-08-20"),
        Advertisement(id: "6", title: "iPhone 14 Pro", price: "105 000 ₽", location: "Москва 6", imageURL: "", createdDate: "2023-08-21"),
    ]

    func fetchData() {
        presenter?.present(advs: mockAdvs)
    }
}
