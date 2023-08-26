//
//  SceneDelegate.swift
//  PetClassified
//
//  Created by Вадим Кузьмин on 24.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let appConfig = AppConfiguration()
        guard let viewController = appConfig.mainViewController as? UIViewController else {
            assertionFailure("Could not cast mainViewController as UIViewController")
            return
        }
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        self.window = window
        window.makeKeyAndVisible()
    }
}

