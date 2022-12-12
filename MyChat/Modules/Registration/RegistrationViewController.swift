//
//  ViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import UIKit


// MARK: - RegistrationDisplayLogic
protocol RegistrationDisplayLogic: ViewController {
    func showUserNameValidationError()
    func showUserNameValidationCorrect()
    func showNameValidationCorrect()
    func showNameValidationError()
    func setupTelephoneNumber(_ codeNumberTelephone: String, _ numberTelephone: String)
    func showCancelAllert()
    func showUserErrorRegisteration()
}

// MARK: - RegistrationViewController
final class RegistrationViewController: ViewController {
        
    var presenter: RegistrationPresentationLogic?
    let registrationPage = RegistrationPage.self
        
    private lazy var registrLabel: UILabel = {
        let label = UILabel()
        label.text = registrationPage.regTextForLabel
        label.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 28)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: UIFont.Roboto.thin.rawValue, size: 28)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = registrationPage.namePlaceHolder
        textField.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 26)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.addTarget(self, action: #selector(isValidNameTextField), for: .editingChanged)
        textField.autocorrectionType = .no
        return textField
    }()

    private lazy var userNameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = registrationPage.userNamePlaceholder
        textField.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 26)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.autocorrectionType = .no
        textField.delegate = self
        textField.addTarget(self, action: #selector(isValidUserNameTextField), for: .editingChanged)
        return textField
    }()
    
    private lazy var descriptionUserNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 15)
        label.textColor = .systemGray
        label.text = registrationPage.userNameDescription
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()

    private lazy var accessButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 20)
        button.setTitle(registrationPage.regButtonText, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonIsTapped), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViewController()
        presenter?.viewDidLoad()
    }
    
    @objc
    func isValidNameTextField() {
        presenter?.didChangeName(nameTextField.text)
    }

    @objc
    func isValidUserNameTextField() {
        presenter?.didChangeUserName(userNameTextField.text)
    }
    
    @objc
    func buttonIsTapped() {
        presenter?.didTapRegisterButton(nameTextField.text, userNameTextField.text)
    }
    
    @objc
    func backButtontapped() {
        presenter?.didTapCancelButton()
    }
}

// MARK: - RegistrationDisplayLogic Impl
extension RegistrationViewController: RegistrationDisplayLogic {
    
    func showNameValidationCorrect() {
        nameTextField.changeStateBottomLine(with: .normal)
    }
    
    func showNameValidationError() {
        nameTextField.changeStateBottomLine(with: .error)
    }
    
    func showUserErrorRegisteration() {
        print(#function)
    }
    
    func showCancelAllert() {
        present(cancelAllert(), animated: true)
    }
    
    func showUserNameValidationCorrect() {
        userNameTextField.changeStateBottomLine(with: .normal)
    }
    
    func showUserNameValidationError() {
        userNameTextField.changeStateBottomLine(with: .error)
    }
    
    func setupTelephoneNumber(_ codeNumberTelephone: String, _ numberTelephone: String) {
        phoneNumberLabel.text = "\(codeNumberTelephone) \(numberTelephone)"
        phoneNumberLabel.attributedText = phoneNumberLabel.addLetterSpacing(label: phoneNumberLabel,
                                                                            spacing: 5.0)
    }
}

// MARK: - UITextFieldDelegate Impl
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameTextField:
            userNameTextField.resignFirstResponder()
            return true
        case nameTextField:
            nameTextField.resignFirstResponder()
            return true
        default:
            return false
        }
    }
}

// MARK: - Private Methods
private extension RegistrationViewController {

    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        setupBackBarItem()
        setupRegistrLabel()
        addSubViews()
        addConstraints()
    }
    
    func cancelAllert() -> UIAlertController {
        lazy var allert = UIAlertController()
        allert = .init(title: registrationPage.shureClouseRegistration,
                       message: registrationPage.shouldShure, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: registrationPage.exit, style: .destructive, handler: { _ in
            self.presenter?.cancelRegistration()
        }))
        allert.addAction(UIAlertAction(title: registrationPage.continueRegistration, style: .default))
        return allert
    }
    
    func setupBackBarItem() {
        let backButton = UIBarButtonItem(title: registrationPage.backBarButton,
                                         style: .done, target: self, action: #selector(backButtontapped))
        self.navigationItem.leftBarButtonItem = backButton
    }

    func setupRegistrLabel() {
        registrLabel.attributedText = registrLabel.addLetterSpacing(label: registrLabel, spacing: 5.0)
    }

    func addSubViews() {
        let arrayViews = [
            registrLabel,
            phoneNumberLabel,
            nameTextField,
            userNameTextField,
            descriptionUserNameLabel,
            accessButton
        ]
        view.myAddSubViews(from: arrayViews)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([
             registrLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 150),
             registrLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             
             phoneNumberLabel.topAnchor.constraint(equalTo: registrLabel.bottomAnchor, constant: 50),
             phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

             nameTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 50),
             nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
             nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),

             userNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
             userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
             userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
             
             descriptionUserNameLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 25),
             descriptionUserNameLabel.leadingAnchor.constraint(equalTo: userNameTextField.leadingAnchor),
             descriptionUserNameLabel.trailingAnchor.constraint(equalTo: userNameTextField.trailingAnchor),

             accessButton.topAnchor.constraint(greaterThanOrEqualTo: userNameTextField.bottomAnchor, constant: 50),
             accessButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -80),
             accessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             accessButton.widthAnchor.constraint(equalToConstant: 220),
             accessButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

