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
        detailImageView.layer.cornerRadius = 10
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
        phoneButton.setTitleColor(.whiteLightDark, for: .normal)
        phoneButton.backgroundColor = .greenUni
        phoneButton.layer.cornerRadius = 16
        phoneButton.layer.masksToBounds = true
        phoneButton.translatesAutoresizingMaskIntoConstraints = false
        return phoneButton
    }()

    private let emailButton: UIButton = {
        let emailButton = UIButton()
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

    private let buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 8
        buttonsStackView.distribution = .fillProportionally
        buttonsStackView.alignment = .center
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsStackView
    }()

    private let emptyView: UIView = {
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }()

    private lazy var emptyViewAnimatableGradient = makeGradientLayer()
    private lazy var emailButtonAnimatableGradient = makeGradientLayer()
    private lazy var phoneButtonAnimatableGradient = makeGradientLayer()

    private var animationLayers = Set<CALayer>()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        emptyViewAnimatableGradient.frame = emptyView.bounds
        emailButtonAnimatableGradient.frame = emailButton.bounds
        phoneButtonAnimatableGradient.frame = phoneButton.bounds
    }

    func configure(adv: DetailAdv, isLoaded: Bool) {
        priceLabel.text = adv.price
        title.text = adv.title
        phoneNumber.text = adv.phoneNumber
        email.text = adv.email
        descriptionLabel.text = adv.description
        location.text = adv.location
        address.text = adv.address
        createdDate.text = adv.createdDate
        setNeedsLayout()
        layoutIfNeeded()
        if isLoaded {
            configureLoadedView()
        }
    }

    func setImage(_ image: UIImage) {
        detailImageView.image = image
    }

    private func setupLayout() {
        addSubview(scrollView)
        [phoneButton, emailButton].forEach { buttonsStackView.addArrangedSubview($0) }
        [detailImageView, priceLabel, title, buttonsStackView, descriptionSeparatorLabel, emptyView, descriptionLabel, contactsLabel, phoneNumber, email, location, address, createdDate].forEach {
            scrollView.addSubview($0)
            makeLeadingTrailingWidthEqualConstraints(of: $0, relativeTo: scrollView)
        }

        emptyView.layer.addSublayer(emptyViewAnimatableGradient)
        emailButton.layer.addSublayer(emailButtonAnimatableGradient)
        phoneButton.layer.addSublayer(phoneButtonAnimatableGradient)
        [emptyViewAnimatableGradient, emailButtonAnimatableGradient, phoneButtonAnimatableGradient].forEach {
            setAnimatableGradient($0)
        }

        let padding: CGFloat = 16

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            detailImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailImageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.9),

            priceLabel.topAnchor.constraint(equalTo: detailImageView.bottomAnchor, constant: padding),

            title.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: padding / 2),

            buttonsStackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding),
            phoneButton.widthAnchor.constraint(equalTo: emailButton.widthAnchor),
            phoneButton.heightAnchor.constraint(equalToConstant: 50),
            emailButton.heightAnchor.constraint(equalToConstant: 50),

            descriptionSeparatorLabel.topAnchor.constraint(equalTo: buttonsStackView.bottomAnchor, constant: padding),
            descriptionLabel.topAnchor.constraint(equalTo: descriptionSeparatorLabel.bottomAnchor, constant: padding / 2),

            emptyView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 50),

            contactsLabel.topAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: padding),
            phoneNumber.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: padding / 2),
            email.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: padding / 4),

            location.topAnchor.constraint(equalTo: email.bottomAnchor, constant: padding / 2),
            address.topAnchor.constraint(equalTo: location.bottomAnchor, constant: padding / 4),

            createdDate.topAnchor.constraint(equalTo: address.bottomAnchor, constant: padding / 2 ),
            createdDate.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: padding)
        ])
    }

    private func makeLeadingTrailingWidthEqualConstraints(of childView: UIView, relativeTo parentView: UIView) {
        childView.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: parentView.trailingAnchor).isActive = true
        childView.widthAnchor.constraint(equalTo: parentView.widthAnchor).isActive = true
    }

    private func makeGradientLayer() -> CAGradientLayer {
        let animatableGradient = CAGradientLayer()
        animatableGradient.locations = [0, 0.1, 0.3]
        animatableGradient.colors = [
            UIColor(red: 0.964, green: 0.964, blue: 0.964, alpha: 1).cgColor,
            UIColor(red: 0.905, green: 0.905, blue: 0.905, alpha: 1).cgColor,
            UIColor(red: 0.807, green: 0.807, blue: 0.807, alpha: 1).cgColor
        ]
        animatableGradient.startPoint = CGPoint(x: 0, y: 0.5)
        animatableGradient.endPoint = CGPoint(x: 1, y: 0.5)
        return animatableGradient
    }

    private func setAnimatableGradient(_ layer: CAGradientLayer) {
        animationLayers.insert(layer)

        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.duration = 2
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
        gradientChangeAnimation.toValue = [0, 0.8, 1]
        layer.add(gradientChangeAnimation, forKey: "locationsChange")
    }

    private func removeAnimatableGradient() {
        animationLayers.forEach { layer in
            layer.removeFromSuperlayer()
        }
    }

    private func configureLoadedView() {
        removeAnimatableGradient()
        emptyView.removeFromSuperview()
        contactsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        emailButton.setTitle(TextStrings.DetailView.emailButton, for: .normal)
        phoneButton.setTitle(TextStrings.DetailView.phoneButton, for: .normal)
    }
}
