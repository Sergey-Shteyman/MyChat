//
//  Router.swift
//  MyChat
//
//  Created by Сергей Штейман on 08.12.2022.
//

import UIKit

// MARK: - Router
protocol Router {
    func setRoot(_ rootViewController: UIViewController)
    func push(_ viewController: UIViewController, _ animated: Bool)
    func popViewController(_ animated: Bool)
    func popToRootViewController(_ animated: Bool)
}

// MARK: - AppRouter
final class AppRouter {
    
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Router impl
extension AppRouter: Router {
    
    func setRoot(_ rootViewController: UIViewController) {
        navigationController = UINavigationController(rootViewController: rootViewController)
        window.rootViewController = navigationController
    }
    
    func push(_ viewController: UIViewController, _ animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(_ animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRootViewController(_ animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
}
