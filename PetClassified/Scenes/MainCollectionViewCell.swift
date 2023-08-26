//
//  MainCollectionViewCell.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    // MARK: - Private Properties
    private let image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        title.textColor = .blackLightDark
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let price: UILabel = {
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        price.textColor = .blackLightDark
        price.translatesAutoresizingMaskIntoConstraints = false
        return price
    }()

    private let location: UILabel = {
        let location = UILabel()
        location.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        location.textColor = .grayUni
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()

    private let createdDate: UILabel = {
        let createdDate = UILabel()
        createdDate.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        createdDate.textColor = .grayUni
        createdDate.translatesAutoresizingMaskIntoConstraints = false
        return createdDate
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK:  - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public Methods
    func configureCell() {
        
    }

    // MARK: - Private Methods
    private func configureView() {
        [image, stackView].forEach { addSubview($0) }
        [title, price, location, createdDate].forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 1),

            stackView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
