//
//  AuthPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 02.12.2022.
//


// MARK: - PresentationAuthLogic
protocol PresentationAuthLogic: AnyObject {
    func didChangeNumber(_ number: String?)
    func didTapAuthButton()
}

// MARK: - AuthPresenter
final class AuthPresenter {
    
    weak var viewController: DisplayAuthLogic?
    
    private let moduleBuilder: Buildable
    
    lazy var validNumber = Bool()
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - PresentationAuthLogic Impl
extension AuthPresenter: PresentationAuthLogic {
    
    func didTapAuthButton() {
        if validNumber {
//            let viewController = moduleBuilder.buildVeryfyModule()
//            viewController.routTo(viewController)
        } else {
            viewController?.showValidationError()
        }
    }
    
    func didChangeNumber(_ number: String?) {
        if validateNumber(number) {
            viewController?.showValidationCorrect()
        } else {
            viewController?.showValidationError()
        }
    }
}

// MARK: - Private methods
private extension AuthPresenter {
    
    func validateNumber(_ number: String?) -> Bool {
        let validateNumberExpression = #"^[0-9]{10,10}$"#
        guard let number = number else {
            return false
        }
        guard number.count == 10 && number.range(
            of: validateNumberExpression,
            options: .regularExpression,
            range: nil) != nil else {
            return false
        }
        validNumber = true
        return true
    }
}
