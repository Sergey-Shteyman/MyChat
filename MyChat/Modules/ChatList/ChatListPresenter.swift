//
//  ChatListPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//

// MARK: - PresentationChatListProtocol
protocol PresentationChatListLogic: AnyObject {
    func didTapChat()
}

// MARK: - ChatListPresenter
final class ChatListPresenter {
    
    weak var viewController: DisplayChatListLogic?
    private let router: Router
    private let modulebuilder: Buildable
    
    init(router: Router, modulebuilder: Buildable) {
        self.router = router
        self.modulebuilder = modulebuilder
    }
}

// MARK: - PresentationChatListProtocol impl
extension ChatListPresenter: PresentationChatListLogic {
    
    func didTapChat() {
        let chatViewController = modulebuilder.buildChatViewController(namePerson: "Person")
        router.push(chatViewController, true)
    }
}
