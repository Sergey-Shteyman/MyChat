//
//  RegistrationPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 30.11.2022.
//


// MARK: - RegistrationPresentationLogic
protocol RegistrationPresentationLogic: AnyObject {
    func didChangeUserName(_ name: String?)
    func didChangeName(_ name: String?)
    func didTapRegisterButton(_ name: String?, _ userName: String?)
    func viewDidLoad()
    func didTapCancelButton()
    func cancelRegistration()
}

// MARK: - RegistrationPresenter
final class RegistrationPresenter {
    
    let validNameMask = MasksValidationFields.validNameField
    
    lazy var validUserName = Bool()
    lazy var validName = Bool()
    
    weak var viewController: RegistrationDisplayLogic?
    
    private let router: Router
    private let apiService: APIServiceable
    private let keychainService: Storagable
    private let defaultService: DefaultServicable
    private let moduleBuilder: Buildable
    private let phoneNumberCode: String
    private let telephoneNumber: String
    
    init(
        router: Router,
        defaultService: DefaultServicable,
        apiService: APIServiceable,
        keychainService: Storagable,
        phoneNumberCode: String,
        telephoneNumber: String,
        moduleBuilder: Buildable
    ) {
        self.router = router
        self.defaultService = defaultService
        self.apiService = apiService
        self.keychainService = keychainService
        self.phoneNumberCode = phoneNumberCode
        self.telephoneNumber = telephoneNumber
        self.moduleBuilder = moduleBuilder
    }
}

// MARK: - RegistrationPresentationLogic Impl
extension RegistrationPresenter: RegistrationPresentationLogic {
    
    func viewDidLoad() {
        viewController?.setupTelephoneNumber(phoneNumberCode, telephoneNumber)
    }
    
    func cancelRegistration() {
        self.router.popToRootViewController(true)
    }
    
    func didTapCancelButton() {
        viewController?.showCancelAllert()
    }
    
    func didTapRegisterButton(_ name: String?, _ userName: String?) {
        guard let name = name,
              let userName = userName else {
            return
        }
        let phone = "\(phoneNumberCode)\(telephoneNumber)"
        if isFieldsAreCorrect() {
            Task {
                do {
                    let accessToken = try keychainService.fetch(for: .accessToken)
                    let body = RegisterBody(
                        phone: phone,
                        name: name,
                        username: userName
                    )
                    let request = RegisterRequest(accessToken: accessToken, body: body)
                    let response = try await apiService.registerUser(request: request)

                    try keychainService.save(response.accessToken, for: .accessToken)
                    try keychainService.save(response.refreshToken, for: .refreshToken)
                    try keychainService.save(phoneNumberCode, for: .code)
                    try keychainService.save(telephoneNumber, for: .phone)
                    defaultService.save(true, forKey: .isUserAuth)

                    await MainActor.run {
                        let tabBarController = moduleBuilder.buildTabBarController(phoneNumberCode: phoneNumberCode,
                                                                                         telephoneNumber: telephoneNumber)
                        router.setRoot(tabBarController, isNavigationBarHidden: true)
                    }
                } catch {
                    await MainActor.run {
                        viewController?.showUserErrorRegisteration()
                    }
                }
            }
        } else {
            viewController?.showUserNameValidationError()
            viewController?.showNameValidationError()
        }
    }
    
    func didChangeName(_ name: String?) {
        isNameFieldCorrect(name)
    }
    
    func didChangeUserName(_ name: String?) {
        isUserNameFieldCorrect(name)
    }
}

// MARK: - private methods
private extension RegistrationPresenter {
    
    func isFieldsAreCorrect() -> Bool {
        guard validUserName && validName else {
            return false
        }
        return true
    }
    
    func isUserNameFieldCorrect(_ userName: String?) {
        if validateName(userName) {
            validUserName = true
            viewController?.showUserNameValidationCorrect()
        } else {
            viewController?.showUserNameValidationError()
            validUserName = false
        }
    }
    
    func isNameFieldCorrect(_ name: String?) {
        guard let name = name else {
            return
        }
        if !name.isEmpty {
            viewController?.showNameValidationCorrect()
            validName = true
        } else {
            viewController?.showNameValidationError()
            validName = false
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

