//
//  MainViewController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func display(advs: [Advertisement])
    func displayLoading(emptyAdvs: [Advertisement])
    func updateCellWithImage(_ images: [String: UIImage], for indexPaths: [IndexPath])
    func displayError(message: String)
}

final class MainViewController: UIViewController {
    private enum Section {
        case empty
        case loaded
    }

    // MARK: - Private Properties
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .whiteLightDark
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private var interactor: MainInteractorProtocol

    private var emptyCells = 0
    private let sections: [Section] = [.empty, .loaded]
    private var cells: [Advertisement] = []
    private var images: [String: UIImage] = [:]

    // MARK: - initializers
    init(interactor: MainInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.prefetchDataSource = self
        collectionView.register(MainCollectionViewCell.self)
        collectionView.register(MainEmptyCollectionViewCell.self)
        configureView()
        interactor.fetchData()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        interactor.cancelAllLoadTasks()
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .whiteLightDark
        configureNavigationBarAppearance()
        
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureNavigationBarAppearance() {
        navigationItem.title = TextStrings.MainViewController.title
        navigationController?.navigationBar.prefersLargeTitles = true

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .whiteLightDark
            appearance.shadowColor = nil
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = sections[section]
        switch section {
        case .empty:
            return emptyCells
        case .loaded:
            return cells.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = sections[indexPath.section]
        switch section {
        case .empty:
            let cell: MainEmptyCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            cell.configureCell()
            return cell
        case .loaded:
            let cell: MainCollectionViewCell = collectionView.dequeueReusableCell(indexPath: indexPath)
            let adv = cells[indexPath.row]
            let image = images[adv.imageURL] ?? UIImage(named: "ImagePlaceholder") ?? UIImage()
            cell.configureCell(adv: adv, image: image)
            return cell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let imageURL = cells[indexPath.row].imageURL
        interactor.fetchImage(for: imageURL)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = cells[indexPath.row].id
        let viewController = DetailViewController(id: id)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageURL = cells[indexPath.row].imageURL
            interactor.fetchImage(for: imageURL)
        }
    }
}

// MARK: - MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    func display(advs: [Advertisement]) {
        emptyCells = 0
        cells = advs
        reloadCollectionViewWithAnimation()
    }

    func updateCellWithImage(_ images: [String : UIImage], for indexPaths: [IndexPath]) {
        self.images = images
        collectionView.reloadItems(at: indexPaths)
    }

    func displayLoading(emptyAdvs: [Advertisement]) {
        emptyCells = emptyAdvs.count
        cells = emptyAdvs
        collectionView.reloadData()
    }

    func displayError(message: String) {
        let alertController = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let refreshAlertAction = UIAlertAction(title: "Попробовать снова", style: .default, handler: { [weak self] _ in
            self?.interactor.fetchData()
        })
        alertController.addAction(refreshAlertAction)
        present(alertController, animated: true)
    }

    private func reloadCollectionViewWithAnimation() {
        CATransaction.begin()
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.collectionView.alpha = 0
        } completion: { [weak self] _ in
            self?.collectionView.reloadData()
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.collectionView.alpha = 1
            }
        }
        CATransaction.commit()
    }
}

