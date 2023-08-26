//
//  MainViewController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

final class MainViewController: UIViewController {
    // MARK: - Private Properties
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .whiteLightDark
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let mockAdvs: [Advertisement] = [
        Advertisement(id: "1", title: "iPhone 11", price: "55 000 ₽", location: "Москва 1", imageURL: "", createdDate: "2023-08-16"),
        Advertisement(id: "2", title: "iPhone 12", price: "65 000 ₽", location: "Москва 2", imageURL: "", createdDate: "2023-08-17"),
        Advertisement(id: "3", title: "iPhone 13", price: "75 000 ₽", location: "Москва 3", imageURL: "", createdDate: "2023-08-18"),
        Advertisement(id: "4", title: "iPhone 14", price: "85 000 ₽", location: "Москва 4", imageURL: "", createdDate: "2023-08-19"),
        Advertisement(id: "5", title: "iPhone 13 Pro", price: "95 000 ₽", location: "Москва 5", imageURL: "", createdDate: "2023-08-20"),
        Advertisement(id: "6", title: "iPhone 14 Pro", price: "105 000 ₽", location: "Москва 6", imageURL: "", createdDate: "2023-08-21"),
    ]

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.register(MainCollectionViewCell.self)
        configureView()
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .whiteLightDark
        navigationItem.title = S.MainViewController.title
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationController?.navigationBar.tintColor = .whiteLightDark

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .whiteLightDark
            appearance.shadowColor = nil
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func makeCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockAdvs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
        cell.configureCell(adv: mockAdvs[indexPath.row])
        return cell
    }
}

