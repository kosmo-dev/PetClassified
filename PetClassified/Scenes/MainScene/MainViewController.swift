//
//  MainViewController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

protocol MainViewControllerProtocol: AnyObject {
    func display(viewModel: MainModels.ViewModel)
    func displayLoading(viewModel: MainModels.ViewModel)
    func updateCellWithImage(viewModel: MainModels.ImageViewModel)
    func displayError(error: MainModels.ErrorMessage)
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
    private lazy var errorController = ErrorController(view: self.view)

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
        errorController.delegate = self
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
        let layout = UICollectionViewCompositionalLayout { section, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 4, bottom: 8, trailing: 4)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            return section
        }
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
            return emptyCells == 0 ? cells.count : 0
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
        interactor.fetchImage(request: MainModels.Request(imageURL: imageURL))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard emptyCells == 0 else { return }
        let adv = cells[indexPath.row]
        let image = images[adv.imageURL]
        let viewController = DetailViewController(advertisement: adv, image: image)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSourcePrefetching
extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageURL = cells[indexPath.row].imageURL
            interactor.fetchImage(request: MainModels.Request(imageURL: imageURL))
        }
    }
}

// MARK: - MainViewControllerProtocol
extension MainViewController: MainViewControllerProtocol {
    func display(viewModel: MainModels.ViewModel) {
        emptyCells = 0
        cells = viewModel.advertisements
        reloadCollectionViewWithAnimation()
    }

    func displayLoading(viewModel: MainModels.ViewModel) {
        emptyCells = viewModel.advertisements.count
        cells = viewModel.advertisements
        collectionView.reloadData()
    }

    func updateCellWithImage(viewModel: MainModels.ImageViewModel) {
        self.images = viewModel.images
        collectionView.reloadItems(at: viewModel.indexPaths)
    }

    func displayError(error: MainModels.ErrorMessage) {
        errorController.showErrorView(with: error.message)
    }

    private func reloadCollectionViewWithAnimation() {
        UIView.transition(with: collectionView, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.collectionView.reloadData()
        }, completion: nil)
    }
}

extension MainViewController: ErrorControllerDelegate {
    func didTapTryAgainButton() {
        errorController.removeErrorView { [weak self] in
            self?.interactor.fetchData()
        }
    }
}

