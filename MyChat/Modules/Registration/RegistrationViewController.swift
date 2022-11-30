//
//  ViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import UIKit

class RegistrationViewController: UIViewController {
        
    private lazy var registrLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont(name: "Roboto-Black", size: 28) 
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Имя"
        textField.font = .systemFont(ofSize: 26)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.delegate = self
        return textField
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.font = .systemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = .lightGray
        label.text = "+7 9109774325"
        return label
    }()
    
    private lazy var accessButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViewController()
        for family: String in UIFont.familyNames
        {
           print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
           {
               print("== \(names)")
           }
        }
    }

    @objc func isValidNameTextField() -> Bool {
        let validateNameExpression = #"^[A-Z]{1,26}[a-z]{1,26}[0-9]{0,10}[_]{0,2}$"#
        if self.nameTextField.text?.range(of: validateNameExpression,
                                          options: .regularExpression,
                                          range: nil) != nil {
            nameTextField.addBottomLine(with: .systemBlue)
            return true
        } else {
            nameTextField.addBottomLine(with: .red)
            return false
        }
    }
    
    @objc func buttonIsTapped() {
        if !isValidNameTextField() {
            nameTextField.addBottomLine(with: .red)
        }
    }
}

// MARK: - UITextFieldDelegate Impl
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard isValidNameTextField() else {
            return false
        }
        nameTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Private Methods
fileprivate extension RegistrationViewController {

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
        NSLayoutConstraint.activate([registrLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
                                     registrLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     phoneNumberLabel.topAnchor.constraint(equalTo: registrLabel.bottomAnchor, constant: 50),
                                     phoneNumberLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     
                                     nameTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 50),
                                     nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
                                     
                                     accessButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
                                     accessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     accessButton.widthAnchor.constraint(equalToConstant: 220),
                                     accessButton.heightAnchor.constraint(equalToConstant: 40)
                                    ])
    }
}

