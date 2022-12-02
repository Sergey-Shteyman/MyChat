//
//  AuthPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 02.12.2022.
//


// MARK: - PresentationAuthLogic
protocol PresentationAuthLogic: AnyObject {
    
}

// MARK: - AuthPresenter
final class AuthPresenter {
    
    weak var viewController: DisplayAuthLogic?
    
    private let moduleBuilder: Buildable
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - PresentationAuthLogic Impl
extension AuthPresenter: PresentationAuthLogic {
    
}
