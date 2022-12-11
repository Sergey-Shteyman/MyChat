//
//  ChatPresenter.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//


// MARK: - PresentationChatLogic
protocol PresentationChatLogic: AnyObject {
    func viewDidLoad()
}

// MARK: - ChatProtocol
final class ChatPresenter {
    
    weak var viewController: DisplayChatLogic?
    private let person: String
    
    init(person: String) {
        self.person = person
    }
}

// MARK: - PresentationChatLogic impl
extension ChatPresenter: PresentationChatLogic {
    func viewDidLoad() {
        viewController?.updateTitle(title: person)
    }
}
