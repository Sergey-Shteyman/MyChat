//
//  ChatPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//


// MARK: - PresentationChatLogic
protocol PresentationChatLogic: AnyObject {
    
}

// MARK: - ChatProtocol
final class ChatPresenter {
    
    weak var viewController: DisplayChatLogic?
}

// MARK: - PresentationChatLogic impl
extension ChatPresenter: PresentationChatLogic {
    
}
