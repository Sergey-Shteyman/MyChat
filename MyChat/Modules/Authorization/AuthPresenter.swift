//
//  AuthPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 02.12.2022.
//


// MARK: - PresentationAuthLogic
protocol PresentationAuthLogic: AnyObject {
    func didChangeNumber(_ number: String?)
    func didTapAuthButton(_ codeNumberPhone: String?, _ number: String?)
}

// MARK: - AuthPresenter
final class AuthPresenter {
    
    weak var viewController: DisplayAuthLogic?
    
    private let moduleBuilder: Buildable
    private let masksValidation = MasksValidationFields()
    
    lazy var validNumber = Bool()
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - PresentationAuthLogic Impl
extension AuthPresenter: PresentationAuthLogic {
    
    func didTapAuthButton(_ codeNumberPhone: String?, _ number: String?) {
        if validNumber {
            guard let number = number,
                  let codeNumberPhone = codeNumberPhone else {
                return
            }
            let viewController = moduleBuilder.buildVerificationModule(codeTelephoneNumber: codeNumberPhone,
                                                                       telephoneNumber: number)
            self.viewController?.routTo(viewController)
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
        let validateNumberExpression = masksValidation.validPhone
        guard let number = number else {
            return false
        }
        guard number.count == 10 && number.range(
            of: validateNumberExpression,
            options: .regularExpression,
            range: nil) != nil else {
            validNumber = false
            return false
        }
        validNumber = true
        return true
    }
}
