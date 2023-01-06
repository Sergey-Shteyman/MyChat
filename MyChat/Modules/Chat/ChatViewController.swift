//
//  ChatViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit
import MessageKit
import InputBarAccessoryView

// MARK: - Sender
struct Sender: SenderType {
    var senderId: String
    var displayName: String
}

// MARK: - Message
struct Message: MessageType {
    var sender: MessageKit.SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKit.MessageKind
}

// MARK: - DisplayChatLogic
protocol DisplayChatLogic: MessagesViewController {
    func updateTitle(title: String)
    func updateCollectionView(viewModel: [MessageType])
}

// MARK: - ChatViewController
final class ChatViewController: MessagesViewController {
    
    var presenter: PresentationChatLogic?
    
    private var messages = [MessageType]()
    private let currentUser: SenderType
    
    init(
        currentUser: SenderType
    ) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        setupViewController()
    }
}

// MARK: - DisplayChatLogic impl
extension ChatViewController: DisplayChatLogic {
    
    func updateTitle(title: String) {
        self.title = title
    }
    
    func updateCollectionView(viewModel: [MessageType]) {
        messages = viewModel
        messagesCollectionView.reloadData()
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
        presenter?.didSendMessage(text)
        inputBar.inputTextView.text = nil
    }
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return message.sender.senderId == currentUser.senderId ? .link : .systemGray4
    }
}

// MARK: - MessagesLayoutDelegate impl
extension ChatViewController:  MessagesLayoutDelegate {
}

// MARK: - MessagesDisplayDelegate impl
extension ChatViewController: MessagesDisplayDelegate {
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.image = message.sender.senderId == currentUser.senderId
        ? UIImage(systemName: "heart.circle.fill")
        : UIImage(systemName: "person")
        avatarView.backgroundColor = .clear
    }
}

// MARK: - ChatViewController private methods
private extension ChatViewController {
    
    func setupViewController() {
        view.backgroundColor = .white
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        showMessageTimestampOnSwipeLeft = true
        messageInputBar.delegate = self
    }
}
