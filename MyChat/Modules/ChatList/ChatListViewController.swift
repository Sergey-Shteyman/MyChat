//
//  ChatListViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit

// MARK: - DisplayChatListLogic
protocol DisplayChatListLogic: ViewController {
    
}

// MARK: - ChatListViewController
final class ChatListViewController: ViewController {
    
    var presenter: PresentationChatListLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// MARK: - DisplayChatListLogic impl
extension ChatListViewController: DisplayChatListLogic {
    
}
