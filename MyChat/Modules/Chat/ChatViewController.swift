//
//  ChatViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView


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
    func updateTitle(title: String)
}

// MARK: - ChatViewController
final class ChatViewController: MessagesViewController {
    
    var presenter: PresentationChatLogic?
    
    private let currentUser = Sender(senderId: "self", displayName: "Sergey") // Можно заполнить текущего юзера по имени
    private let otherUser = Sender(senderId: "other", displayName: "Person")
    
    var messages = [MessageType]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
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
        showMessageTimestampOnSwipeLeft = true
        messageInputBar.delegate = self
    }
}

// MARK: - DisplayChatLogic impl
extension ChatViewController: DisplayChatLogic {
    
    func updateTitle(title: String) {
        self.title = title
    }
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

// MARK: - InputBarAccessoryViewDelegate impl
extension ChatViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date(), kind: .text(text)))
        inputBar.inputTextView.text = nil
        messagesCollectionView.reloadDataAndKeepOffset()
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        let sender = message.sender
        if sender.senderId == self.otherUser.senderId {
            return .cyan
        }
        return .link
    }
}

// MARK: - MessagesLayoutDelegate impl
extension ChatViewController:  MessagesLayoutDelegate {
}

// MARK: - MessagesDisplayDelegate impl
extension ChatViewController: MessagesDisplayDelegate {
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let sender = message.sender
        if sender.senderId == self.otherUser.senderId {
            avatarView.image = UIImage(systemName: "person")
            avatarView.backgroundColor = .clear
        } else {
            avatarView.image = UIImage(systemName: "heart.circle.fill") 
            avatarView.backgroundColor = .clear
        }

    }
}

