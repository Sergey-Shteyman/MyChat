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
}

final class ProfileViewController: ViewController {
    var presenter: ProfilePresentationLogic?

    private let avatarButton = UIButton(type: .system)
    private let phoneTextField = UITextField()
    private let usernameTextField = UITextField()
    private let cityTextField = UITextField()
    private let bithdateTextField = UITextField()
    // TODO: -
    private let goroskopTextField = UITextField()
    private let aboutTextView = UITextView()

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
}

extension ProfileViewController: ProfileDisplayLogic {
    func updateView(_ viewModel: ProfileViewModel) {}

    func showError() {}
}

private extension ProfileViewController {
    func setupViewController() {
        view.backgroundColor = .red

        stackView.addArrangedSubviews(
            avatarButton,
            phoneTextField,
            usernameTextField,
            cityTextField,
            bithdateTextField,
            goroskopTextField,
            aboutTextView
        )
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
