//
//  ErrorView.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 29.08.2023.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapButton()
}

final class ErrorView: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.textColor = .whiteLightDark
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let button: UIButton = {
        let button = UIButton()
        button.setTitle(TextStrings.ErrorView.retryButton, for: .normal)
        button.setTitleColor(.whiteLightDark, for: .normal)
        button.addTarget(nil, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    weak var delegate: ErrorViewDelegate?

    func configureView(text: String) {
        backgroundColor = .redUni
        layer.cornerRadius = 10
        layer.masksToBounds = true
        label.text = text
        [label, button].forEach { addSubview($0) }

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),

            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }


    @objc private func buttonTapped() {
        delegate?.didTapButton()
    }
}
