//
//  ChatViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit


// MARK: - DisplayChatLogic
protocol DisplayChatLogic: ViewController {
    
}

// MARK: - ChatViewController
final class ChatViewController: ViewController {
    
    var presenter: PresentationChatLogic?
    
    
}

// MARK: - DisplayChatLogic impl
extension ChatViewController: DisplayChatLogic {
    
}
