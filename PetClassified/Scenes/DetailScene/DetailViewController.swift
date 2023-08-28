//
//  DetailViewController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject {
    func display(adv: DetailAdv)
}

final class DetailViewController: UIViewController {
    // MARK: - Private Properties
    private let detailView = DetailView()
    private var interactor: DetailInteractorProtocol?

    private let id: String

    init(id: String) {
        self.id = id
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
        configureView()
        interactor?.fetchData(for: id)
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
    func display(adv: DetailAdv) {
        detailView.configure(adv: adv)
    }
}
