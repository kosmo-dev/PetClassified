//
//  DetailViewController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    // MARK: - Private Properties
    private let detailView = DetailView()

    // MARK: - View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        detailView.configure()
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
}
