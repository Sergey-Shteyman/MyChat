//
//  ProfileViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit

protocol ProfileDisplayLogic: ViewController {
    func updateView(_ viewModel: ProfileViewModel)
    func showError()
    func routTo(_ viewController: UIViewController)
}

final class ProfileViewController: ViewController {
    var presenter: ProfilePresentationLogic?

    private let avatarImageView = UIImageView()
    private let phoneLabel = UILabel()
    private let usernameLabel = UILabel()
    private let cityLabel = UILabel()
    private let bithdateLabel = UILabel()
    // TODO: -
    private let goroskopLabel = UILabel()
    private let aboutLabel = UILabel()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc
    private func didTapEditButton() {
        presenter?.didTapEditButton()
    }
}

extension ProfileViewController: ProfileDisplayLogic {
    
    func routTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func updateView(_ viewModel: ProfileViewModel) {}

    func showError() {}
}

private extension ProfileViewController {
    func setupViewController() {
        view.backgroundColor = .red

        stackView.addArrangedSubviews(
            avatarImageView,
            phoneLabel,
            usernameLabel,
            cityLabel,
            bithdateLabel,
            goroskopLabel,
            aboutLabel
        )
    }
}
