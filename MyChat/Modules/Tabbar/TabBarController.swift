//
//  TabBarController.swift
//  MyChat
//
//  Created by Сергей Штейман on 10.12.2022.
//

import UIKit

// MARK: - TabbarController
final class TabBarController: UITabBarController {
    
    private let moduleBuilder: Buildable
    private let phoneNumberCode: String
    private let telephoneNumber: String
    
    init(
        moduleBuilder: Buildable,
        phoneNumberCode: String,
        telephoneNumber: String
    ) {
        self.moduleBuilder = moduleBuilder
        self.phoneNumberCode = phoneNumberCode
        self.telephoneNumber = telephoneNumber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        self.navigationItem.hidesBackButton = true
    }
}

// MARK: - Private methods
private extension TabBarController {
    
    func setupController() {
        let chatListPage = moduleBuilder.buildChatListViewController()
        chatListPage.tabBarItem.title = "Chat"
        chatListPage.tabBarItem.image = UIImage(systemName: "house")
        let profilePage = moduleBuilder.buildProfileViewContrioller(phoneNumberCode, telephoneNumber)
        let navbarProfile = UINavigationController(rootViewController: profilePage)
        profilePage.tabBarItem.title = "Profile"
        profilePage.tabBarItem.image = UIImage(systemName: "person")
        
//        let editButton = UIBarButtonItem(title: "Edit",
//                                         style: .done, target: nil, action: nil)
//        profilePage.navigationItem.rightBarButtonItem = editButton
        
        viewControllers = [chatListPage, navbarProfile]
    }
}
