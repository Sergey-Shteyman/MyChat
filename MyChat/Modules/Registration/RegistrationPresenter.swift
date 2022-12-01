//
//  RegistrationPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 30.11.2022.
//


// MARK: - RegistrationPresentationLogic
protocol RegistrationPresentationLogic: AnyObject {
    func didChangeName(_ name: String?)
    func didTapRegisterButton()
}

// MARK: - RegistrationPresenter
final class RegistrationPresenter {
    
    let validNameMask = MasksValidationFields().validNameField
    
    lazy var validName = Bool()
    
    weak var viewController: RegistrationDisplayLogic?
    private let moduleBuilder: Buildable
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - RegistrationPresentationLogic Impl
extension RegistrationPresenter: RegistrationPresentationLogic {
    
    func didTapRegisterButton() {
        if isFieldsAreCorrect() {
            
        } else {
            viewController?.showNameValidationError()
        }
    }
    
    func didChangeName(_ name: String?) {
        isNameValid(name)
    }
}

// MARK: - private methods
private extension RegistrationPresenter {
    
    func isFieldsAreCorrect() -> Bool{
        guard validName else {
            return false
        }
        return true
    }
    
    func isNameValid(_ name: String?) {
        if validateName(name) {
            validName = true
            viewController?.showNameValidationCorrect()
        } else {
            viewController?.showNameValidationError()
        }
    }
    
    func validateName(_ name: String?) -> Bool {
        let validateNameExpression = validNameMask
        guard let _ = name?.range(of: validateNameExpression,
                                     options: .regularExpression,
                                     range: nil) else {
            return false
        }
        return true
    }
}

