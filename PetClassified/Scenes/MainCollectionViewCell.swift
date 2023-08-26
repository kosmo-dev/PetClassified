//
//  MainCollectionViewCell.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    // MARK: - Private Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        stackView.axis = .vertical
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
    func configureCell(adv: Advertisement) {
        imageView.image = UIImage(systemName: "photo")
        title.text = adv.title
        price.text = adv.price
        location.text = adv.location
        createdDate.text = adv.createdDate
    }

    // MARK: - Private Methods
    private func configureView() {
        [imageView, stackView].forEach { addSubview($0) }
        [title, price, location, createdDate].forEach { stackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),

            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
