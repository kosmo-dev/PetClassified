//
//  DetailView.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

final class DetailView: UIView {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let detailImageView: UIImageView = {
        let detailImageView = UIImageView()
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.layer.masksToBounds = true
        detailImageView.translatesAutoresizingMaskIntoConstraints = false
        return detailImageView
    }()

    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        priceLabel.textColor = .blackLightDark
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()

    private let title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.textColor = .blackLightDark
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let contactsLabel: UILabel = {
        let contactsLabel = UILabel()
        contactsLabel.text = TextStrings.DetailView.contactsLabel
        contactsLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        contactsLabel.textColor = .blackLightDark
        contactsLabel.translatesAutoresizingMaskIntoConstraints = false
        return contactsLabel
    }()

    private let phoneNumber: UILabel = {
        let phoneNumber = UILabel()
        phoneNumber.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        phoneNumber.textColor = .grayUni
        phoneNumber.translatesAutoresizingMaskIntoConstraints = false
        return phoneNumber
    }()

    private let email: UILabel = {
        let email = UILabel()
        email.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        email.textColor = .grayUni
        email.translatesAutoresizingMaskIntoConstraints = false
        return email
    }()

    private let phoneButton: UIButton = {
        let phoneButton = UIButton()
        phoneButton.setTitle(TextStrings.DetailView.phoneButton, for: .normal)
        phoneButton.setTitleColor(.whiteLightDark, for: .normal)
        phoneButton.backgroundColor = .greenUni
        phoneButton.layer.cornerRadius = 16
        phoneButton.layer.masksToBounds = true
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        return phoneButton
    }()

    private let emailButton: UIButton = {
        let emailButton = UIButton()
        emailButton.setTitle(TextStrings.DetailView.emailButton, for: .normal)
        emailButton.setTitleColor(.whiteLightDark, for: .normal)
        emailButton.backgroundColor = .blueUni
        emailButton.layer.cornerRadius = 16
        emailButton.layer.masksToBounds = true
        emailButton.translatesAutoresizingMaskIntoConstraints = false
        return emailButton
    }()

    private let descriptionSeparatorLabel: UILabel = {
        let descriptionSeparatorLabel = UILabel()
        descriptionSeparatorLabel.text = TextStrings.DetailView.descriptionSeparatorLabel
        descriptionSeparatorLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        descriptionSeparatorLabel.textColor = .blackLightDark
        descriptionSeparatorLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionSeparatorLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        descriptionLabel.textColor = .blackLightDark
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        return descriptionLabel
    }()

    private let location: UILabel = {
        let location = UILabel()
        location.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        location.textColor = .blackLightDark
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()

    private let address: UILabel = {
        let address = UILabel()
        address.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        address.textColor = .blackLightDark
        address.translatesAutoresizingMaskIntoConstraints = false
        return address
    }()

    private let createdDate: UILabel = {
        let createdDate = UILabel()
        createdDate.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        createdDate.textColor = .grayUni
        createdDate.translatesAutoresizingMaskIntoConstraints = false
        return createdDate
    }()

    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 8
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()

    private let buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 8
        buttonsStackView.distribution = .fill
        buttonsStackView.alignment = .center
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsStackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(adv: DetailAdv) {
        detailImageView.image = UIImage(named: "ImagePlaceholder")
        priceLabel.text = adv.price
        title.text = adv.title
        phoneNumber.text = adv.phoneNumber
        email.text = adv.email
        descriptionLabel.text = adv.description
        location.text = adv.location
        address.text = adv.address
        createdDate.text = adv.createdDate
    }

    private func setupLayout() {
        addSubview(scrollView)
        [detailImageView, verticalStackView].forEach { scrollView.addSubview($0) }
        [phoneButton, emailButton].forEach { buttonsStackView.addArrangedSubview($0) }
        [priceLabel, title, buttonsStackView, descriptionSeparatorLabel, descriptionLabel, contactsLabel, phoneNumber, email, location, address, createdDate].forEach { verticalStackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            detailImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailImageView.heightAnchor.constraint(equalToConstant: 250),
            detailImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            verticalStackView.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: 8),
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            buttonsStackView.heightAnchor.constraint(equalToConstant: 60),
            buttonsStackView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
            phoneButton.widthAnchor.constraint(equalTo: emailButton.widthAnchor),
            phoneButton.heightAnchor.constraint(equalToConstant: 50),
            emailButton.heightAnchor.constraint(equalToConstant: 50),

            descriptionSeparatorLabel.heightAnchor.constraint(equalToConstant: 40),
            contactsLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
