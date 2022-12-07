//
//  VerificationPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 03.12.2022.
//

import UIKit


// MARK: - VerificationPresentationLogic
protocol VerificationPresentationLogic: AnyObject {
    func didTapVerifyButton(fields: [String?])
    func viewDidLoad()
    func prepareScreen()
}

// MARK: - VerificationPresenter
final class VerificationPresenter {
    
    weak var viewController: VerificationDisplayLogic?
    
    private let moduleBuilder: Buildable
    private let codeTelephoneNumber: String
    private let telephoneNumber: String
    private let validFields = MasksValidationFields()
    private let apiService: APIServiceable
    private let keychainService: Storagable
    
    init(
        apiService: APIServiceable,
        keychainService: Storagable,
        moduleBuilder: Buildable,
        codeTelephoneNumber: String,
        telephoneNumber: String
    ) {
        self.apiService = apiService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
        self.codeTelephoneNumber = codeTelephoneNumber
        self.telephoneNumber = telephoneNumber
    }
}

// MARK: - VerificationPresentationLogic
extension VerificationPresenter: VerificationPresentationLogic {
    
    func prepareScreen() {
        viewController?.clearFields()
        viewController?.filedsResignSelection()
    }
    
    func viewDidLoad() {
        viewController?.setupPhoneNumberTitle(phoneCode: codeTelephoneNumber, phone: telephoneNumber)
    }
    
    func didTapVerifyButton(fields: [String?]) {
        var codeValue = ""
        for value in fields {
            guard let value = value else {
                return
            }
            codeValue.append(value)
        }
        if codeValue == validFields.validCodeSMS {
            let phone = "\(codeTelephoneNumber)\(telephoneNumber)"
            verifyUser(codeValue, phone)
        } else {
            codeValue = ""
            viewController?.showInvalidCodeAllert()
        }
    }
}

// MARK: - private methods
private extension VerificationPresenter {
    
    func verifyUser(_ code: String, _ phone: String) {
        Task {
            do {
                let body = VerifyCodeBody(phone: phone, code: code)
                let request = VerifyCodeRequest(body: body)
                let response = try await apiService.verifyCode(request: request)
                try keychainService.save(response.accessToken, for: .accessToken)
                try keychainService.save(response.refreshToken, for: .refreshToken)

                await MainActor.run {
                    if response.isUserExists {
                        // TODO: - Вынести в роутер?
                        let chatListViewController = moduleBuilder.buildChatListViewController()
                        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                            return
                        }
                        appDelegate.window?.rootViewController = UINavigationController(rootViewController: chatListViewController)
                    } else {
                        let registerPage = moduleBuilder.buildRegistrationModule(codeTelephoneNumber,
                                                                                           telephoneNumber)
                        viewController?.routTo(registerPage)
                    }
                }
            } catch {
                await MainActor.run {
                    viewController?.showVerificationError
                }
            }
        }
    }
}
