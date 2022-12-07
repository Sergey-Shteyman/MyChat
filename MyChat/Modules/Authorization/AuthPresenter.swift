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
    private let apiService: APIServiceable
    private let masksValidation = MasksValidationFields()
    
    lazy var validNumber = Bool()
    
    init(apiService: APIServiceable, moduleBuilder: Buildable) {
        self.apiService = apiService
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - PresentationAuthLogic Impl
extension AuthPresenter: PresentationAuthLogic {
    
    func didTapAuthButton(_ codeNumberPhone: String?, _ number: String?) {
        if validNumber {
            authUser(codeNumberPhone, number)
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
    
    func authUser(_ codeNumberPhone: String?, _ number: String?) {
        guard let number = number,
              let codeNumberPhone = codeNumberPhone else {
            return
        }
        let phone = "\(codeNumberPhone)\(number)"
        Task {
            do {
                let body = AuthBody(phone: phone)
                let request = AuthRequest(body: body)
                let response = try await apiService.auth(request: request)
                
                await MainActor.run {
                    if response.isSuccess {
                        let verifyPage = moduleBuilder.buildVerificationModule(codeTelephoneNumber: codeNumberPhone,
                                                                               telephoneNumber: number)
                        viewController?.routTo(verifyPage)
                    } else {
                        viewController?.showAuthError()
                    }
                }
            } catch {
                await MainActor.run {
                    viewController?.showAuthError()
                }
            }
        }
    }
    
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
