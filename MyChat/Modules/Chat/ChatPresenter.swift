//
//  ChatPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//
import MessageKit


// MARK: - PresentationChatLogic
protocol PresentationChatLogic: AnyObject {
    func viewDidLoad()
    func didSendMessage(_ text: String)
}

// MARK: - ChatProtocol
final class ChatPresenter {
    
    weak var viewController: DisplayChatLogic?
    private let person: String
    private let currentUser: Sender
    private let otherUser: Sender
    
    private var messages: [MessageType] = []
    
    init(
        person: String,
        currentUser: Sender,
        otherUser: Sender
    ) {
        self.person = person
        self.currentUser = currentUser
        self.otherUser = otherUser
    }
}

// MARK: - PresentationChatLogic impl
extension ChatPresenter: PresentationChatLogic {
    func viewDidLoad() {
        messages = [
            Message(sender: currentUser,
                    messageId: "1",
                    sentDate: Date().addingTimeInterval(-86400),
                    kind: .text("Hello!")
                   ),
            Message(sender: otherUser,
                    messageId: "2",
                    sentDate: Date().addingTimeInterval(-70000),
                    kind: .text("Hi!")
                   ),
            Message(sender: currentUser,
                    messageId: "3",
                    sentDate: Date().addingTimeInterval(-66400),
                    kind: .text("Goodbye")
                   ),
            Message(sender: otherUser,
                    messageId: "4",
                    sentDate: Date().addingTimeInterval(-56400),
                    kind: .text("OK(")
                   )
        ]
        viewController?.updateTitle(title: person)
        viewController?.updateCollectionView(viewModel: messages)
    }
    
    func didSendMessage(_ text: String) {
        messages.append(
            Message(sender: currentUser,
                    messageId: UUID().uuidString,
                    sentDate: Date(),
                    kind: .text(text))
        )
        viewController?.updateCollectionView(viewModel: messages)
    }
}
