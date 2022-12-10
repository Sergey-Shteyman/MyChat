//
//  ModuleBuilder.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import Foundation


// MARK: - Buildable
protocol Buildable {
    func buildSplashViewController() -> SplashViewController
    func buildWellcomeModule() -> WellcomViewController
    func buildAuthPageModule() -> AuthViewController
    func buildVerificationModule(codeTelephoneNumber: String, telephoneNumber: String) -> VerificationViewController
    func buildRegistrationModule(_ phoneNumberCode: String, _ telephoneNumber: String) -> RegistrationViewController
    func buildChatViewController() -> ChatViewController
    func buildChatListViewController() -> ChatListViewController
    func buildProfileViewContrioller(_ phoneNumberCode: String, _ telephoneNumber: String) -> ProfileViewController
    func buildEditProfileModule(_ userModel: UserModel,
                                _ delegate: EditProfilePresenterDelegate?,
                                _ phoneNumberCode: String,
                                _ telephoneNumber: String) -> EditProfileViewController
}

// MARK: - ModuleBuilder
final class ModuleBuilder {
    
    private let databaseService: DatabaseServicable
    private let decoderService: Decoderable
    private let networkService: Networkable
    private let apiService: APIServiceable
    private let keychainService: Storagable
    private let defaultsService: DefaultServicable
    private let router: Router

    init(
        databaseService: DatabaseServicable,
        router: Router
    ) {
        self.router = router
        self.databaseService = databaseService
        self.decoderService = DecoderService()
        self.networkService = NetworkService(decoderService: decoderService)
        self.apiService = APIService(networkService: networkService)
        self.keychainService = KeychainService()
        self.defaultsService = DefaultsService()
    }
}

// MARK: - Buildable Impl
extension ModuleBuilder: Buildable {
    
    func buildSplashViewController() -> SplashViewController {
        let viewController = SplashViewController()
        let presenter = SplashPresenter(
            router: router,
            keychainService: keychainService,
            defaultsService: defaultsService,
            moduleBuilder: self
        )

        viewController.presenter = presenter
        presenter.viewController = viewController

        return viewController
    }
    
    func buildWellcomeModule() -> WellcomViewController {
        let viewController = WellcomViewController()
        let presenter = WellcomePresenter(moduleBuilder: self,
                                          router: router)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildAuthPageModule() -> AuthViewController {
        let viewController = AuthViewController()
        let presenter = AuthPresenter(apiService: apiService,
                                      moduleBuilder: self, router: router)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildVerificationModule(codeTelephoneNumber: String, telephoneNumber: String) -> VerificationViewController {
        let viewController = VerificationViewController()
        let presenter = VerificationPresenter(
            router: router,
            defaultService: defaultsService,
            apiService: apiService,
            keychainService: keychainService,
            moduleBuilder: self,
            codeTelephoneNumber: codeTelephoneNumber,
            telephoneNumber: telephoneNumber
        )
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildRegistrationModule(_ phoneNumberCode: String, _ telephoneNumber: String) -> RegistrationViewController {
        let viewController = RegistrationViewController()
        let presenter = RegistrationPresenter(router: router,
                                              defaultService: defaultsService,
                                              apiService: apiService,
                                              keychainService: keychainService,
                                              phoneNumberCode: phoneNumberCode,
                                              telephoneNumber: telephoneNumber,
                                              moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildProfileViewContrioller(_ phoneNumberCode: String, _ telephoneNumber: String) -> ProfileViewController {
        let viewController = ProfileViewController()
        let presenter = ProfilePresenter(router: router,
                                         codeNumberPhone: telephoneNumber,
                                         numberPhone: phoneNumberCode,
                                         databaseService: databaseService,
                                         moduleBuilder: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        return viewController
    }
    
    func buildEditProfileModule(_ userModel: UserModel,
                                _ delegate: EditProfilePresenterDelegate?,
                                _ phoneNumberCode: String,
                                _ telephoneNumber: String) -> EditProfileViewController {
        let viewController = EditProfileViewController()
        let presenter = EditProfilePresenter(
            router: router,
            databaseService: databaseService,
            userModel: userModel,
            codeNumberPhone: telephoneNumber,
            numberPhone: phoneNumberCode,
            apiService: apiService,
            keychainService: keychainService
                                             
        )
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.delegate = delegate
        return viewController
    }
    
    func buildChatViewController() -> ChatViewController {
        ChatViewController()
    }

    func buildChatListViewController() -> ChatListViewController {
        ChatListViewController()
    }
}
