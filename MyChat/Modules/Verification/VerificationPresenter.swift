//
//  VerificationPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 03.12.2022.
//


// MARK: - VerificationPresentationLogic
protocol VerificationPresentationLogic: AnyObject {
    func firstSquareSelected(_ value: String?)
    func didTapVerifyButton(fields: [String?])
    func getPhoneNumber()
    func prepareScreen()
}

// MARK: - VerificationPresenter
final class VerificationPresenter {
    
    weak var viewController: VerificationDisplayLogic?
    
    private let moduleBuilder: Buildable
    private let codeTelephoneNumber: String
    private let telephoneNumber: String
    private let validFields = MasksValidationFields()
    
    init(moduleBuilder: Buildable, codeTelephoneNumber: String, telephoneNumber: String) {
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
    
    func getPhoneNumber() {
        viewController?.setupTitle(phoneCode: codeTelephoneNumber, phone: telephoneNumber)
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
            let viewConroller = moduleBuilder.buildRegistrationModule(codeTelephoneNumber, telephoneNumber)
            self.viewController?.routTo(viewConroller)
        } else {
            codeValue = ""
            viewController?.showInvalidCodeAllert()
//            viewController?.clearFields()
        }
    }
    
    func firstSquareSelected(_ value: String?) {
//        if value?.count == 1 {
//            viewController.
//        }
    }
}
