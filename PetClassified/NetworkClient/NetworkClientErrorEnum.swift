//
//  NetworkErrorEnum.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 29.08.2023.
//

import Foundation

enum NetworkClientError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
}

extension NetworkClientError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .httpStatusCode(let code):
            let stringCode = String(code)
            return TextStrings.ErrorMessages.httpStatusCode + stringCode
        case .urlRequestError(_):
            return TextStrings.ErrorMessages.urlRequestError
        case .urlSessionError:
            return TextStrings.ErrorMessages.urlSessionError
        case .parsingError:
            return TextStrings.ErrorMessages.parsingError
        }
    }
}
