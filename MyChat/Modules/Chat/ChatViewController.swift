//
//  ChatViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit
import MessageKit


struct Sender: SenderType {
    var senderId: String
    var displayName: String
}


struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}



// MARK: - DisplayChatLogic
protocol DisplayChatLogic: MessagesViewController {
    
}

// MARK: - ChatViewController
final class ChatViewController: MessagesViewController {
    
    var presenter: PresentationChatLogic?
    
    private let currentUser = Sender(senderId: "self", displayName: "Sergey") // Можно заполнить текущего юзера по имени
    private let otherUser = Sender(senderId: "other", displayName: "MyChat")
    
    var messages = [MessageType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messages.append(Message(sender: currentUser,
                                messageId: "1",
                                sentDate: Date().addingTimeInterval(-86400),
                                kind: .text("Hello!")))
        messages.append(Message(sender: otherUser,
                                messageId: "2",
                                sentDate: Date().addingTimeInterval(-70000),
                                kind: .text("Hi!")))
        messages.append(Message(sender: currentUser,
                                messageId: "3",
                                sentDate: Date().addingTimeInterval(-66400),
                                kind: .text("Goodbye")))
        messages.append(Message(sender: otherUser,
                                messageId: "4",
                                sentDate: Date().addingTimeInterval(-56400),
                                kind: .text("OK(")))
        
        view.backgroundColor = .white
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
    }
}

// MARK: - DisplayChatLogic impl
extension ChatViewController: DisplayChatLogic {
    
}

// MARK: - MessagesDataSource impl
extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> MessageKit.SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        messages.count
    }
}

// MARK: - MessagesLayoutDelegate impl
extension ChatViewController:  MessagesLayoutDelegate {
    
}

// MARK: - MessagesDisplayDelegate
extension ChatViewController: MessagesDisplayDelegate {
    
}

