//
//  DetailViewController.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 27.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    // MARK: - Private Methods
    private func configureView() {
        view.backgroundColor = .whiteLightDark
        configureNavigationBarAppearance()
    }

    private func configureNavigationBarAppearance() {
        navigationController?.navigationBar.tintColor = .blackLightDark

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
