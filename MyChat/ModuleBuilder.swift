//
//  ModuleBuilder.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import Foundation


// MARK: - Buildable
protocol Buildable {
    func buildMainModule() -> ViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {
    
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {
    
    func buildMainModule() -> ViewController {
        let viewController = ViewController()
//        let presenter = MainPresenter(fileReaderManager: fileReaderManager,
//                                      jsonDecoderManager: jsonDecoderManager,
//                                      moduleBuilder: self)
//
//        viewController.presenter = presenter
//        presenter.viewController = viewController
        
        return viewController
    }
}
