//
//  Strings.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import Foundation

struct TextStrings {
    struct MainViewController {
        static let title = "Объявления"
    }
    struct DetailView {
        static let descriptionSeparatorLabel = "Описание"
        static let contactsLabel = "Контакты:"
        static let phoneButton = "Позвонить"
        static let emailButton = "Написать"
    }
    struct ErrorView {
        static let retryButton = "Попробовать снова"
    }
    struct ErrorMessages {
        static let httpStatusCode = "Ошибка соединения. Код ошибки: "
        static let urlRequestError = "Ошибка запроса"
        static let urlSessionError = "Нет сети"
        static let parsingError = "Ошибка. Свяжитесь с разработчиком. Код ошибки 0"
    }
}
