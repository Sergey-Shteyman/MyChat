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
    func routToRoot()
    func routTo(_ viewController: UIViewController)
    func showUserErrorRegisteration()
}

// MARK: - RegistrationViewController
final class RegistrationViewController: ViewController {
        
    var presenter: RegistrationPresentationLogic?
    let registrationModel = RegistrationPageModel()
        
    private lazy var registrLabel: UILabel = {
        let label = UILabel()
        label.text = registrationModel.regTextForLabel
        label.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 28)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = registrationModel.namePlaceHolder
        textField.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 26)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.addTarget(self, action: #selector(isValidNameTextField), for: .editingChanged)
        return textField
    }()
    
    private lazy var userNameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = registrationModel.userNamePlaceholder
        textField.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 26)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.delegate = self
        textField.addTarget(self, action: #selector(isValidUserNameTextField), for: .editingChanged)
        return textField
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
    
    private lazy var accessButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 20)
        button.setTitle(registrationModel.regButtonText, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        accessButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchDown)
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
    
    func routTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showNameValidationCorrect() {
        nameTextField.changeStateBottomLine(with: .normal)
    }
    
    func showNameValidationError() {
        nameTextField.changeStateBottomLine(with: .error)
    }
    
    func showUserErrorRegisteration() {
        print(#function)
    }
    
    func routToRoot() {
        navigationController?.popToRootViewController(animated: true)
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
        userNameTextField.resignFirstResponder()
        return true
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
        allert = .init(title: registrationModel.shureClouseRegistration,
                       message: registrationModel.shouldShure, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: registrationModel.exit, style: .destructive, handler: { _ in
            self.presenter?.cancelRegistration()
        }))
        allert.addAction(UIAlertAction(title: registrationModel.continueRegistration, style: .default))
        return allert
    }
    
    func setupBackBarItem() {
        let backButton = UIBarButtonItem(title: registrationModel.backBarButton,
                                         style: .done, target: self, action: #selector(backButtontapped))
        self.navigationItem.leftBarButtonItem = backButton
    }

    func setupRegistrLabel() {
        registrLabel.attributedText = registrLabel.addLetterSpacing(label: registrLabel, spacing: 5.0)
    }

    func addSubViews() {
        let arrayViews = [registrLabel, nameTextField, phoneNumberLabel, userNameTextField,
                          accessButton]
        view.myAddSubViews(from: arrayViews)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([registrLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 150),
                                     registrLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     phoneNumberLabel.topAnchor.constraint(equalTo: registrLabel.bottomAnchor, constant: 50),
                                     phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     nameTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 50),
                                     nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
                                     
                                     userNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
                                     userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
                                     
                                     accessButton.topAnchor.constraint(greaterThanOrEqualTo: userNameTextField.bottomAnchor,
                                                                       constant: 50),
                                     accessButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,
                                                                          constant: -80),
                                     accessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     accessButton.widthAnchor.constraint(equalToConstant: 220),
                                     accessButton.heightAnchor.constraint(equalToConstant: 40)
                                    ])
    }
}

