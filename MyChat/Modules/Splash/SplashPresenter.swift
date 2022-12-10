//
//  SplashPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

protocol SplashPresentationLogic: AnyObject {
    func viewDidLoad()
}

final class SplashPresenter {
    weak var viewController: SplashDisplayLogic?

    private let keychainService: Storagable
    private let defaultsService: DefaultServicable
    private let moduleBuilder: Buildable
    private let router: Router

    init(
        router: Router,
        keychainService: Storagable,
        defaultsService: DefaultServicable,
        moduleBuilder: Buildable
    ) {
        self.router = router
        self.keychainService = keychainService
        self.defaultsService = defaultsService
        self.moduleBuilder = moduleBuilder
    }
}

extension SplashPresenter: SplashPresentationLogic {
    func viewDidLoad() {
        do {
            let code = try keychainService.fetch(for: .code)
            let phone = try keychainService.fetch(for: .phone)
            let isUserAuth = defaultsService.fetchObject(type: Bool.self, forKey: .isUserAuth) ?? false
            
            let viewController = isUserAuth
            ? moduleBuilder.buildTabBarController(phoneNumberCode: code, telephoneNumber: phone)
            : moduleBuilder.buildWellcomeModule()
            router.setRoot(viewController)
        } catch {
            let wellcomeModule = moduleBuilder.buildWellcomeModule()
            router.setRoot(wellcomeModule)
        }
    }
}
