//
//  SceneDelegate.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let databaseService = DatabaseService()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupRootViewController(with: windowScene)
        setupRealmConficuration()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}

// MARK: - private extension
private extension SceneDelegate {
    func setupRootViewController(with windowScene: UIWindowScene) {
        let window = UIWindow(windowScene: windowScene)
        let router = AppRouter(window: window)
        let moduleBuilder = ModuleBuilder(databaseService: databaseService, router: router)
        let viewController = EditProfileViewController()
        router.setRoot(viewController)
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func setupRealmConficuration() {
        let version: UInt64 = 2
        let config = Realm.Configuration(
            schemaVersion: version,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < version) {
                    print("Realm Updated to version - \(version)")
                    self.databaseService.deleteAll(with: migration)
                }
            })
        Realm.Configuration.defaultConfiguration = config
    }
}

