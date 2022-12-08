//
//  EditProfileViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

import UIKit

protocol EditProfileDisplayLogic: ViewController {
    func updateView(_ viewModel: ProfileViewModel)
    func popToPreviousPage()
    func showError()
}

final class EditProfileViewController: ViewController {
    
    var presenter: EditProfilePresentationLogic?

    private let avatarButton = UIButton(type: .system)
    private let phoneTextField = UITextField()
    private let usernameTextField = UITextField()
    private let cityTextField = UITextField()
    private let bithdateTextField = UITextField()
    // TODO: -
    private let horoscopeTextField = UITextField()
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
        presenter?.viewWillDisappear()
    }
    
    @objc
    private func didTapAvatarButton() {
        print(#function)
    }
}

extension EditProfileViewController: EditProfileDisplayLogic {
    
    func popToPreviousPage() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateView(_ viewModel: ProfileViewModel) {}

    func showError() {}
}

private extension EditProfileViewController {
    
    func setupViewController() {
        view.backgroundColor = .red
        stackView.addArrangedSubviews(
            avatarButton,
            phoneTextField,
            usernameTextField,
            cityTextField,
            bithdateTextField,
            horoscopeTextField,
            aboutTextView
        )
    }
}
