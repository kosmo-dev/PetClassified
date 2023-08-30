//
//  Strings.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import Foundation

struct TextStrings {
    struct MainViewController {
        static let title = NSLocalizedString("MainViewController.title", comment: "")
    }
    struct DetailView {
        static let descriptionSeparatorLabel = NSLocalizedString("DetailView.descriptionSeparatorLabel", comment: "")
        static let contactsLabel = NSLocalizedString("DetailView.contactsLabel", comment: "")
        static let phoneButton = NSLocalizedString("DetailView.phoneButton", comment: "")
        static let emailButton = NSLocalizedString("DetailView.emailButton", comment: "")
    }
    struct ErrorView {
        static let retryButton = NSLocalizedString("ErrorView.retryButton", comment: "")
    }
    struct ErrorMessages {
        static let httpStatusCode = NSLocalizedString("ErrorMessages.httpStatusCode", comment: "")
        static let urlRequestError = NSLocalizedString("ErrorMessages.urlRequestError", comment: "")
        static let urlSessionError = NSLocalizedString("ErrorMessages.urlSessionError", comment: "")
        static let parsingError = NSLocalizedString("ErrorMessages.parsingError", comment: "")
    }
}
