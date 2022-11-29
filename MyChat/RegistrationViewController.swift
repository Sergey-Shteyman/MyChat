//
//  ViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 28.11.2022.
//

import UIKit
import CountryPicker

class RegistrationViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private lazy var registrLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .preferredFont(forTextStyle: .title1)
        label.font = .systemFont(ofSize: 28)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var nameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Имя"
        textField.font = .systemFont(ofSize: 26)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        return textField
    }()
    
    private lazy var containerCountryTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Выберите страну"
        textField.font = .systemFont(ofSize: 26)
        textField.addBottomLine(with: .lightGray)
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
    
    private lazy var phoneTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Номер телефона"
        textField.font = .systemFont(ofSize: 26)
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = UIKeyboardType.numberPad
        return textField
    }()
    
    private lazy var accessButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitle("Зарегистрироваться", for: .highlighted)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.setTitleColor(UIColor.purple, for: .highlighted)
        button.titleLabel?.textAlignment = .center
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupViewController()
    }
    
    @objc func isValidNameTextField() -> Bool {
        let validateNameExpression = #"^[А-Я]{1,}[а-я]{1,}$"#
        if self.nameTextField.text?.range(of: validateNameExpression,
                                          options: .regularExpression,
                                          range: nil) != nil {
            nameTextField.addBottomLine(with: .lightGray)
            return true
        } else {
            nameTextField.addBottomLine(with: .red)
            return false
        }    }
    
    @objc func isValidNumberTextField() -> Bool {
        let validateNumberExpression = #"^[0-9]{11,11}$"#
        if (phoneTextField.text?.count)! == 11 &&
            phoneTextField.text?.range(of: validateNumberExpression,
                                        options: .regularExpression,
                                        range: nil) != nil {
            phoneTextField.resignFirstResponder()
            phoneTextField.addBottomLine(with: .lightGray)
            return true
            
        } else {
            phoneTextField.addBottomLine(with: .red)
            return false
        }
    }
    
    @objc func buttonIsTapped() {
        
        if isValidNumberTextField() && isValidNameTextField() {
        } else if isValidNameTextField() && !isValidNumberTextField() {
            phoneTextField.addBottomLine(with: .red)
        } else if !isValidNameTextField() && isValidNumberTextField() {
            nameTextField.addBottomLine(with: .red)
        } else if !isValidNumberTextField() && !isValidNameTextField() {
            phoneTextField.addBottomLine(with: .red)
            nameTextField.addBottomLine(with: .red)
        }
    }
}

// MARK: - CountryPickerDelegate Impl
extension RegistrationViewController: CountryPickerDelegate {
    
    func countryPhoneCodePicker(_ picker: CountryPicker,
                                didSelectCountryWithName name: String,
                                countryCode: String, phoneCode: String, flag: UIImage) {
        containerCountryTextField.setupLeftSideImage(with: flag)
        containerCountryTextField.text = name
        phoneTextField.text = phoneCode
    }
}

// MARK: - UITextFieldDelegate Impl
extension RegistrationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard isValidNameTextField() else {
            return false
        }
        nameTextField.resignFirstResponder()
        phoneTextField.becomeFirstResponder()
        return true
    }
}

// MARK: - Private Methods
fileprivate extension RegistrationViewController {

    func setupViewController() {
        nameTextField.delegate = self
        view.addTapGestureToHideKeyboard()
        setupScrollView()
        setupRegistrLabel()
        inputCountryPicker()
        addTargets()
        addSubViews()
        addConstraints()
    }
    
    func setupScrollView() {
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: 0, height: accessButton.frame.maxY + 10)
    }

    func setupRegistrLabel() {
        registrLabel.attributedText = registrLabel.addLetterSpacing(label: registrLabel, spacing: 5.0)
    }
    
    func inputCountryPicker() {
        containerCountryTextField.inputView = countryPicker
    }
    
    func addTargets() {
        nameTextField.addTarget(self, action: #selector(isValidNameTextField), for: UIControl.Event.editingChanged)
        phoneTextField.addTarget(self, action: #selector(isValidNumberTextField), for: UIControl.Event.editingChanged)
        accessButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchDown)
    }

    func addSubViews() {
        view.myAddSubView(scrollView)
        let arrayViews = [registrLabel, nameTextField, containerCountryTextField, phoneTextField, accessButton]
        scrollView.addSubViewOnScrollVeiw(for: arrayViews, scrollView: scrollView)
    }

    func addConstraints() {
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                                     scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                     scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

                                     registrLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
                                     registrLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                     registrLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                     
                                     nameTextField.topAnchor.constraint(equalTo: registrLabel.bottomAnchor, constant: 50),
                                     nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
                                     
                                     containerCountryTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50),
                                     containerCountryTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     containerCountryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
                                     
                                     phoneTextField.topAnchor.constraint(equalTo: containerCountryTextField.bottomAnchor, constant: 50),
                                     phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
                                     
                                     accessButton.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 50),
                                     accessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     accessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
                                    ])
    }
}

