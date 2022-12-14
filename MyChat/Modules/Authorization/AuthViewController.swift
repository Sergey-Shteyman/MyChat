//
//  AuthViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 02.12.2022.
//

import UIKit
import CountryPicker


// MARK: - DisplayAuthLogic
protocol DisplayAuthLogic: ViewController {
    func showValidationCorrect()
    func showValidationError()
    func showAuthError()
}

// MARK: - AuthViewController
final class AuthViewController: ViewController {
    
    var presenter: PresentationAuthLogic?
    
    private let authPage = AuthPageConstants.self
    private let robotoFont = RobotoFont.self
    
    private lazy var telephoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.regular, size: 28)
        label.textAlignment = .center
        label.text = authPage.phoneNumber
        return label
    }()
    
    private lazy var telephoneDescription: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: robotoFont.regular, size: 15)
        label.textAlignment = .center
        label.text = authPage.descriptionPhone
        return label
    }()
    
    private lazy var containerCountryTextField: TextField = {
        let textField = TextField()
        textField.placeholder = authPage.chouseCountry
        textField.font = .systemFont(ofSize: 26)
        return textField
    }()

    private lazy var countryPicker: CountryPicker = {
        let picker = CountryPicker()
        let locale = Locale.current
        let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String
        let theme = CountryViewTheme(countryCodeTextColor: .black,
                                     countryNameTextColor: .black,
                                     rowBackgroundColor: .white,
                                     showFlagsBorder: false)
        picker.theme = theme
        picker.countryPickerDelegate = self
        picker.showPhoneNumbers = true
        if let code = code {
            picker.setCountry(code)
        }
        return picker
    }()

    private lazy var phoneCodeTextField: TextField = {
        let textField = TextField()
        textField.font = .systemFont(ofSize: 26)
        return textField
    }()

    private lazy var phoneNumberTextField: TextField = {
        let textField = TextField()
        textField.placeholder = authPage.phonePlaceholder
        textField.font = .systemFont(ofSize: 26)
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = UIKeyboardType.numberPad
        textField.addTarget(self,
                            action: #selector(isValidNumberTextField),
                            for: UIControl.Event.editingChanged)
        return textField
    }()
    
    private lazy var authButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 20)
        button.setTitle(authPage.authButton, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonIsTapped), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewController()
    }
    
    @objc func isValidNumberTextField() {
        presenter?.didChangeNumber(phoneNumberTextField.text)
    }
    
    @objc
    func buttonIsTapped() {
        presenter?.didTapAuthButton(phoneCodeTextField.text, phoneNumberTextField.text)
    }
}

// MARK: - DisplayAuthLogic Impl
extension AuthViewController: DisplayAuthLogic {
    
    func showAuthError() {
        print(#function)
    }
    
    func showValidationCorrect() {
        phoneNumberTextField.changeStateBottomLine(with: .normal)
        phoneNumberTextField.resignFirstResponder()
    }
    
    func showValidationError() {
        phoneNumberTextField.changeStateBottomLine(with: .error)
    }
}

// MARK: - CountryPickerDelegate Impl
extension AuthViewController: CountryPickerDelegate {

    func countryPhoneCodePicker(_ picker: CountryPicker,
                                didSelectCountryWithName name: String,
                                countryCode: String, phoneCode: String, flag: UIImage) {
        containerCountryTextField.setupLeftSideImage(with: flag)
        containerCountryTextField.text = name
        phoneCodeTextField.text = phoneCode
    }
}

// MARK: - Private methods
private extension AuthViewController {
    
    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        inputCountryPicker()
        addSubViews()
        addConstraints()
    }
    
    func inputCountryPicker() {
        containerCountryTextField.inputView = countryPicker
        phoneCodeTextField.inputView = countryPicker
    }
    
    func addSubViews() {
        let subViews = [telephoneLabel, telephoneDescription,
                        containerCountryTextField, phoneCodeTextField,
                        phoneNumberTextField, authButton]
        view.myAddSubViews(from: subViews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            telephoneLabel.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 150),
            telephoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            telephoneDescription.topAnchor.constraint(equalTo: telephoneLabel.bottomAnchor, constant: 20),
            telephoneDescription.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            telephoneDescription.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            containerCountryTextField.topAnchor.constraint(equalTo: telephoneDescription.bottomAnchor, constant: 50),
            containerCountryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            containerCountryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            phoneCodeTextField.topAnchor.constraint(equalTo: containerCountryTextField.bottomAnchor, constant: 50),
            phoneCodeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            phoneCodeTextField.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -150),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: containerCountryTextField.bottomAnchor, constant: 50),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneCodeTextField.trailingAnchor, constant: 30),
            
            authButton.topAnchor.constraint(greaterThanOrEqualTo: phoneNumberTextField.bottomAnchor, constant: 50),
            authButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -80),
            authButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authButton.widthAnchor.constraint(equalToConstant: 220),
            authButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
