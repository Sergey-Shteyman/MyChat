//
//  SplashPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit

protocol SplashPresentationLogic: AnyObject {
    func viewDidLoad()
}

final class SplashPresenter {
    weak var viewController: SplashDisplayLogic?

    private let keychainService: Storagable
    private let defaultsService: DefaultServicable
    private let moduleBuilder: Buildable

    init(
        keychainService: Storagable,
        defaultsService: DefaultServicable,
        moduleBuilder: Buildable
    ) {
        self.keychainService = keychainService
        self.defaultsService = defaultsService
        self.moduleBuilder = moduleBuilder
    }
}

extension SplashPresenter: SplashPresentationLogic {
    func viewDidLoad() {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let isUserAuth = defaultsService.fetchObject(type: Bool.self, forKey: .isUserAuth)
        else {
            viewController?.showError()
            return
        }

        let viewController = isUserAuth
        ? moduleBuilder.buildChatListViewController()
        : moduleBuilder.buildAuthPageModule()

        appDelegate.window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
}
