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
    func buildVerificationModule(codeTelephoneNumber: String, telephoneNumber: String) -> VerificationViewController
    func buildRegistrationModule(_ phoneNumberCode: String, _ telephoneNumber: String) -> RegistrationViewController
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
    
    func buildVerificationModule(codeTelephoneNumber: String, telephoneNumber: String) -> VerificationViewController {
        let viewController = VerificationViewController()
        let presenter = VerificationPresenter(moduleBuilder: self,
                                              codeTelephoneNumber: codeTelephoneNumber,
                                              telephoneNumber: telephoneNumber)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildRegistrationModule(_ phoneNumberCode: String, _ telephoneNumber: String) -> RegistrationViewController {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter(phoneNumberCode: phoneNumberCode,
                                              telephoneNumber: telephoneNumber,
                                              moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
}
