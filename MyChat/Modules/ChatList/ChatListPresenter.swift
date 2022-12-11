//
//  ChatListPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//

// MARK: - PresentationChatListProtocol
protocol PresentationChatListLogic: AnyObject {
    
}

// MARK: - ChatListPresenter
final class ChatListPresenter {
    
    weak var viewController: DisplayChatListLogic?
    private let router: Router
    
    init(router: Router) {
        self.router = router
    }
}

// MARK: - PresentationChatListProtocol impl
extension ChatListPresenter: PresentationChatListLogic {
    
}
