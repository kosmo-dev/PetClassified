//
//  DetailViewController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func display(_ viewModel: DetailModels.ViewModel)
    func displayError(_ errorMessage: DetailModels.ErrorMessage)
}

final class DetailViewController: UIViewController {
    // MARK: - Private Properties
    private let detailView = DetailView()
    private var interactor: DetailInteractorProtocol?
    private lazy var errorController = ErrorController(view: self.view)

    private let advertisement: Advertisement
    private let image: UIImage?


    init(advertisement: Advertisement, image: UIImage?) {
        self.advertisement = advertisement
        self.image = image
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorController.delegate = self
        configureView()
        let request = DetailModels.Request(advertisement: advertisement, image: image)
        interactor?.fetchData(request)
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .whiteLightDark
        configureNavigationBarAppearance()
    }

    private func configureNavigationBarAppearance() {
        navigationController?.navigationBar.tintColor = .blackLightDark
        navigationItem.largeTitleDisplayMode = .never

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .whiteLightDark
            appearance.shadowColor = nil
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        }
    }

    private func setup() {
        var presenter: DetailPresenterProtocol = DetailPresenter()
        interactor = DetailInteractor()
        interactor?.presenter = presenter
        presenter.viewController = self
    }
}

// MARK: - DetailViewControllerProtocol
extension DetailViewController: DetailViewControllerProtocol {
    func display(_ viewModel: DetailModels.ViewModel) {
        detailView.configure(adv: viewModel.advertisement, isLoaded: viewModel.isLoaded)
        detailView.setImage(viewModel.image)
    }

    func displayError(_ errorMessage: DetailModels.ErrorMessage) {
        errorController.showErrorView(with: errorMessage.message)
    }
}

// MARK: - ErrorControllerDelegate
extension DetailViewController: ErrorControllerDelegate {
    func didTapTryAgainButton() {
        errorController.removeErrorView { [weak self] in
            guard let self else { return }
            self.interactor?.fetchData(DetailModels.Request(advertisement: self.advertisement, image: self.image))
        }
    }
}
