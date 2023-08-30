//
//  ErrorController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 29.08.2023.
//

import UIKit

protocol ErrorControllerDelegate: AnyObject {
    func didTapTryAgainButton()
}

final class ErrorController {
    weak var delegate: ErrorControllerDelegate?

    private weak var view: UIView?

    private var errorView: ErrorView = {
        let errorView = ErrorView()
        errorView.translatesAutoresizingMaskIntoConstraints = false
        return errorView
    }()

    private let padding: CGFloat = 50
    private var initialBottomConstraint: NSLayoutConstraint?
    private var finalBottomConstraint: NSLayoutConstraint?

    private var isShowing = false

    init(view: UIView) {
        self.view = view
        errorView.delegate = self
    }

    func showErrorView(with message: String) {
        guard let view, !isShowing else { return }
        isShowing = true
        errorView.configureView(text: message)

        view.addSubview(errorView)

        NSLayoutConstraint.activate([
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.widthAnchor.constraint(equalToConstant: view.frame.width - padding)
        ])

        initialBottomConstraint = errorView.topAnchor.constraint(equalTo: view.bottomAnchor)
        initialBottomConstraint?.isActive = true

        view.layoutIfNeeded()

        initialBottomConstraint?.isActive = false
        finalBottomConstraint = errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding / 2)
        finalBottomConstraint?.isActive = true

        UIView.animate(withDuration: 0.2) {
            self.view?.layoutIfNeeded()
        }
    }

    func removeErrorView(completion: @escaping () -> Void) {
        finalBottomConstraint?.isActive = false

        initialBottomConstraint?.isActive = true
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.view?.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.errorView.removeFromSuperview()
            self?.isShowing = false
            completion()
        }
    }
}

extension ErrorController: ErrorViewDelegate {
    func didTapButton() {
        delegate?.didTapTryAgainButton()
    }
}
