//
//  ModuleBuilder.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import Foundation


// MARK: - Buildable
protocol Buildable {
    func buildMainModule() -> RegistrationViewController
    func buildSelectionPageModule() -> SelectionPageViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {
    
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {
    
    func buildMainModule() -> RegistrationViewController {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter(moduleBuilder: self)

        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildSelectionPageModule() -> SelectionPageViewController {
        let viewController = SelectionPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        let presenter = SelectionPagePresenter(moduleBuilder: self)
        
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
