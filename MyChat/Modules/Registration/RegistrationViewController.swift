//
//  ViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import UIKit


// MARK: - RegistrationDisplayLogic
protocol RegistrationDisplayLogic: AnyObject {
    func showNameValidationError()
    func showNameValidationCorrect()
}

// MARK: - RegistrationViewController
final class RegistrationViewController: UIViewController {
    
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
        textField.placeholder = registrationModel.namePlaceholder
        textField.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 26)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.delegate = self
        return textField
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: UIFont.Roboto.thin.rawValue, size: 28)
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        label.text = registrationModel.userPhone
        return label
    }()
    
    private lazy var accessButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 20)
        button.setTitle(registrationModel.regButtonText, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViewController()
    }

    @objc
    func isValidNameTextField() {
        presenter?.didChangeName(nameTextField.text)
    }
    
    @objc
    func buttonIsTapped() {
        presenter?.didTapRegisterButton()
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
}

// MARK: - UITextFieldDelegate Impl
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Private Methods
private extension RegistrationViewController {

    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        setupRegistrLabel()
        setupNumberPhoneLabel()
        addTargets()
        addSubViews()
        addConstraints()
    }

    func setupRegistrLabel() {
        registrLabel.attributedText = registrLabel.addLetterSpacing(label: registrLabel, spacing: 5.0)
    }
    
    func setupNumberPhoneLabel() {
        phoneNumberLabel.attributedText = phoneNumberLabel.addLetterSpacing(label: phoneNumberLabel, spacing: 5.0)
    }
    
    func addTargets() {
        nameTextField.addTarget(self, action: #selector(isValidNameTextField), for: UIControl.Event.editingChanged)
        accessButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchDown)
    }

    func addSubViews() {
        let arrayViews = [registrLabel, phoneNumberLabel, nameTextField,
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
                                     
                                     accessButton.topAnchor.constraint(greaterThanOrEqualTo: nameTextField.bottomAnchor,
                                                                       constant: 50),
                                     accessButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,
                                                                          constant: -80),
                                     accessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     accessButton.widthAnchor.constraint(equalToConstant: 220),
                                     accessButton.heightAnchor.constraint(equalToConstant: 40)
                                    ])
    }
}

