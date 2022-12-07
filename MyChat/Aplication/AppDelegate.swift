//
//  AppDelegate.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//
//
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        // Override point for customization after application launch.
//        return true
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//    }
//
//
//}

import RealmSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private let databaseService = DatabaseService()
    private lazy var moduleBuilder = ModuleBuilder(databaseService: databaseService)

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()
        setupRealmConficuration()
        return true
    }

    private func setupRootViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = moduleBuilder.buildRegistrationModule("+7", "000") // buildSplashViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    private func setupRealmConficuration() {
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

