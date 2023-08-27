//
//  MainEmptyCollectionViewCell.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 26.08.2023.
//

import UIKit

final class MainEmptyCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    // MARK: - Private Properties
    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4
        verticalStackView.alignment = .leading
        verticalStackView.distribution = .equalSpacing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        return verticalStackView
    }()

    private lazy var squareView = makeEmptyView()
    private lazy var view1 = makeEmptyView()
    private lazy var view2 = makeEmptyView()
    private lazy var view3 = makeEmptyView()
    private lazy var view4 = makeEmptyView()

    private lazy var squareAnimatableGradient = makeGradientLayer()
    private lazy var gradient1 = makeGradientLayer()
    private lazy var gradient2 = makeGradientLayer()
    private lazy var gradient3 = makeGradientLayer()
    private lazy var gradient4 = makeGradientLayer()

    // MARK: - Initializtors
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func layoutSubviews() {
        super.layoutSubviews()
        squareAnimatableGradient.frame = squareView.bounds
        gradient1.frame = view1.bounds
        gradient2.frame = view2.bounds
        gradient3.frame = view3.bounds
        gradient4.frame = view4.bounds
    }

    // MARK: - Public Methods
    func configureCell() {
        setNeedsLayout()
        layoutIfNeeded()
    }

    // MARK: - Private Methods
    private func configureView() {
        addSubview(verticalStackView)
        [squareView, view1, view2, view3, view4].forEach { verticalStackView.addArrangedSubview($0)}
        squareView.layer.addSublayer(squareAnimatableGradient)
        view1.layer.addSublayer(gradient1)
        view2.layer.addSublayer(gradient2)
        view3.layer.addSublayer(gradient3)
        view4.layer.addSublayer(gradient4)

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            squareView.heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, multiplier: 3 / 5),
            squareView.widthAnchor.constraint(equalTo: squareView.heightAnchor, multiplier: 1),
            view1.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 4 / 5),
            view2.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 1),
            view3.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 1),
            view4.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 3 / 5)
        ])
        [view1, view2, view3, view4].forEach { $0.heightAnchor.constraint(equalToConstant: 10).isActive = true }
        [squareAnimatableGradient, gradient1, gradient2, gradient3, gradient4].forEach { setAnimatableGradient($0) }
    }

    private func setAnimatableGradient(_ layer: CAGradientLayer) {
        let gradientChangeAnimation = CABasicAnimation(keyPath: "locations")
        gradientChangeAnimation.duration = 1.5
        gradientChangeAnimation.repeatCount = .infinity
        gradientChangeAnimation.fromValue = [0, 0.1, 0.3]
        gradientChangeAnimation.toValue = [0, 0.8, 1]
        layer.add(gradientChangeAnimation, forKey: "locationsChange")
    }

    private func makeEmptyView() -> UIView {
        let emptyView = UIView()
        emptyView.backgroundColor = .clear
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        return emptyView
    }

    private func makeGradientLayer() -> CAGradientLayer {
        let animatableGradient = CAGradientLayer()
        animatableGradient.locations = [0, 0.1, 0.3]
        animatableGradient.colors = [
            UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 0.5).cgColor,
            UIColor(red: 0.531, green: 0.533, blue: 0.553, alpha: 0.5).cgColor,
            UIColor(red: 0.431, green: 0.433, blue: 0.453, alpha: 0.5).cgColor
        ]
        animatableGradient.startPoint = CGPoint(x: 0, y: 0.5)
        animatableGradient.endPoint = CGPoint(x: 1, y: 0.5)
        return animatableGradient
    }
}
