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
    
    private lazy var chatListTableView: UITableView = {
        let tableView = UITableView()
        tableView.myRegister(ChatCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
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
        setupViewController()
    }
}

// MARK: - DisplayChatListLogic impl
extension ChatListViewController: DisplayChatListLogic {
    
}

// MARK: - UITableViewDelegate
extension ChatListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapChat()
    }
}

// MARK: - UITableViewDataSource impl
extension ChatListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.myDequeueReusableCell(type: ChatCell.self, indePath: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

// MARK: - Private methods
private extension ChatListViewController {
    
    func setupViewController() {
        view.backgroundColor = .white
        addSubViews()
        setupNavigationBar()
        addConstraints()
    }
    
    func addSubViews() {
        view.myAddSubView(chatListTableView)
    }
    
    // TODO: -
    func setupNavigationBar() {
        title = "M Y  C H A T"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            chatListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chatListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chatListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chatListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
