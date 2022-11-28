//
//  SceneDelegate.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupRootViewController(with: windowScene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}

// MARK: - private extension
private extension SceneDelegate {
    func setupRootViewController(with windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let moduleBuilder = ModuleBuilder()
        let mainViewController = moduleBuilder.buildMainModule()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

