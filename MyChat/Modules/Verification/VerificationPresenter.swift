//
//  VerificationPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 03.12.2022.
//


// MARK: - VerificationPresentationLogic
protocol VerificationPresentationLogic: AnyObject {
    func viewDidLoad()
    func completeCode(_ code: String)
}

// MARK: - VerificationPresenter
final class VerificationPresenter {
    
    weak var viewController: VerificationDisplayLogic?
    
    private let router: Router
    private let moduleBuilder: Buildable
    private let codeTelephoneNumber: String
    private let telephoneNumber: String
    private let validFields = MasksValidationFields.self
    private let apiService: APIServiceable
    private let keychainService: Storagable
    private let defaultService: DefaultServicable
    
    init(
        router: Router,
        defaultService: DefaultServicable,
        apiService: APIServiceable,
        keychainService: Storagable,
        moduleBuilder: Buildable,
        codeTelephoneNumber: String,
        telephoneNumber: String
    ) {
        self.router = router
        self.defaultService = defaultService
        self.apiService = apiService
        self.keychainService = keychainService
        self.moduleBuilder = moduleBuilder
        self.codeTelephoneNumber = codeTelephoneNumber
        self.telephoneNumber = telephoneNumber
    }
}

// MARK: - VerificationPresentationLogic
extension VerificationPresenter: VerificationPresentationLogic {
    
    func completeCode(_ code: String) {
        if code.count == 6 {
            if code == validFields.validCodeSMS {
                let phone = "\(codeTelephoneNumber)\(telephoneNumber)"
                verifyUser(code, phone)
            }
            else {
                viewController?.showInvalidCodeAllert()
            }
        }
    }
    
    func viewDidLoad() {
        viewController?.setupPhoneNumberTitle(phoneCode: codeTelephoneNumber, phone: telephoneNumber)
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
                
                if response.isUserExists,
                   let accessToken = response.accessToken,
                   let refreshToken = response.refreshToken {
                    
                    try keychainService.save(accessToken, for: .accessToken)
                    try keychainService.save(refreshToken, for: .refreshToken)
                    try keychainService.save(codeTelephoneNumber, for: .code)
                    try keychainService.save(telephoneNumber, for: .phone)
                    defaultService.save(true, forKey: .isUserAuth)
                }

                await MainActor.run {
                    if response.isUserExists {
                        let tabBarController = moduleBuilder.buildTabBarController(phoneNumberCode: codeTelephoneNumber,
                                                                                         telephoneNumber: telephoneNumber)
                        router.setRoot(tabBarController, isNavigationBarHidden: true)
                    } else {
                        let registerPage = moduleBuilder.buildRegistrationModule(codeTelephoneNumber,
                                                                                           telephoneNumber)
                        router.push(registerPage, true)
                    }
                }
            } catch {
                await MainActor.run {
                    viewController?.showVerificationError()
                }
            }
        }
    }
}
