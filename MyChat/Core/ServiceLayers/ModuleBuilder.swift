//
//  ModuleBuilder.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import Foundation


// MARK: - Buildable
protocol Buildable {
    func buildWellcomeModule() -> WellcomViewController
    func buildAuthPageModule() -> AuthViewController
    func buildVerificationModule() -> VerificationViewController
    func buildRegistrationModule() -> RegistrationViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {
    
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {
    
    func buildWellcomeModule() -> WellcomViewController {
        let viewController = WellcomViewController()
        let presenter = WellcomePresenter(moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildAuthPageModule() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter(moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildVerificationModule() -> VerificationViewController {
        let viewController = VerificationViewController()
        let presenter = VerificationPresenter(moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildRegistrationModule() -> RegistrationViewController {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter(moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
