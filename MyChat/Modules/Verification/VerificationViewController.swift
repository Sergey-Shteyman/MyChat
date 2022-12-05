//
//  VerificationViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 03.12.2022.
//

import UIKit


// MARK: - VerificationDisplayLogic
protocol VerificationDisplayLogic: AnyObject {
    func showInvalidCodeAllert()
    func setupTitle(phoneCode: String, phone: String)
    func clearFields()
    func routTo(_ viewController: UIViewController)
}

// MARK: - VerificationViewController
final class VerificationViewController: UIViewController {

    private let robotoFont = RobotoFont()
    
    var presenter: VerificationPresentationLogic?
    
    private lazy var phoneTitile: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "message")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "iphone")
        return imageView
    }()
    
    private lazy var messagePhoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 25)
        label.textAlignment = .center
        label.text = "Проверьте свои сообщения"
        return label
    }()
    
    private lazy var messagePhoneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 15)
        label.textAlignment = .center
        label.text = "Мы отправили сообщение с кодом подтверждения на ваш мобильный телефон"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var firstCodeSquare: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 6
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 23)
        textField.addTarget(self,
                            action: #selector(firstCodeSquareChanged),
                            for: .editingChanged)
        return textField
    }()
    
    private lazy var secondCodeSquare: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 6
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 23)
        textField.addTarget(self,
                            action: #selector(secondCodeSquareChanged),
                            for: .editingChanged)
        return textField
    }()
    
    private lazy var thirdCodeSquare: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 6
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 23)
        textField.addTarget(self,
                            action: #selector(thirdCodeSquareChanged),
                            for: .editingChanged)
        return textField
    }()
    
    private lazy var fourthCodeSquare: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 6
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 23)
        textField.addTarget(self,
                            action: #selector(fourthCodeSquareChanged),
                            for: .editingChanged)
        return textField
    }()
    
    private lazy var fifthCodeSquare: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 6
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 23)
        textField.addTarget(self,
                            action: #selector(fifthCodeSquareChanged),
                            for: .editingChanged)
        return textField
    }()
    
    private lazy var sixthCodeSquare: UITextField = {
        let textField = UITextField()
        textField.keyboardType = UIKeyboardType.numberPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.cornerRadius = 6
        textField.textAlignment = .center
        textField.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 23)
        textField.addTarget(self,
                            action: #selector(sixthCodeSquareChanged),
                            for: .editingChanged)
        return textField
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 20)
        button.setTitle("Д А Л Е Е", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonIsTapped), for: .touchDown)
        return button
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstCodeSquare.becomeFirstResponder()
        firstCodeSquare.stateForTextField(with: .selected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewController()
    }
    
    @objc
    func firstCodeSquareChanged() {
        firstCodeSquare.stateForTextField(with: .selected)
        if firstCodeSquare.text?.count == 1 {
            firstCodeSquare.stateForTextField(with: .normal)
        }
        secondCodeSquare.stateForTextField(with: .selected)
        secondCodeSquare.becomeFirstResponder()
//        presenter?.firstSquareSelected(firstCodeSquare.text)
    }
    
    @objc
    func secondCodeSquareChanged() {
        secondCodeSquare.stateForTextField(with: .selected)
        if secondCodeSquare.text?.count == 1 {
            secondCodeSquare.stateForTextField(with: .normal)
        }
        thirdCodeSquare.stateForTextField(with: .selected)
        thirdCodeSquare.becomeFirstResponder()
    }
    
    @objc
    func thirdCodeSquareChanged() {
        thirdCodeSquare.stateForTextField(with: .selected)
        if thirdCodeSquare.text?.count == 1 {
            thirdCodeSquare.stateForTextField(with: .normal)
        }
        fourthCodeSquare.stateForTextField(with: .selected)
        fourthCodeSquare.becomeFirstResponder()
    }
    
    @objc
    func fourthCodeSquareChanged() {
        fourthCodeSquare.stateForTextField(with: .selected)
        if fourthCodeSquare.text?.count == 1 {
            fourthCodeSquare.stateForTextField(with: .normal)
        }
        fifthCodeSquare.stateForTextField(with: .selected)
        fifthCodeSquare.becomeFirstResponder()
    }
    
    @objc
    func fifthCodeSquareChanged() {
        fifthCodeSquare.stateForTextField(with: .selected)
        if fifthCodeSquare.text?.count == 1 {
            fifthCodeSquare.stateForTextField(with: .normal)
        }
        sixthCodeSquare.stateForTextField(with: .selected)
        sixthCodeSquare.becomeFirstResponder()
    }
    
    @objc
    func sixthCodeSquareChanged() {
        sixthCodeSquare.stateForTextField(with: .selected)
        if sixthCodeSquare.text?.count == 1 {
            sixthCodeSquare.stateForTextField(with: .normal)
            sixthCodeSquare.resignFirstResponder()
        }
    }
    
    @objc
    func buttonIsTapped() {
        let codeInFields = getCode()
        presenter?.didTapVerifyButton(fields: codeInFields)
    }
}

// MARK: - VerificationDisplayLogic
extension VerificationViewController: VerificationDisplayLogic {
    
    func routTo(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showInvalidCodeAllert() {
        present(invalidCodeAllert(), animated: true)
    }
    
    func setupTitle(phoneCode: String, phone: String) {
        phoneTitile.text = "\(phoneCode) \(phone)"
        self.navigationItem.titleView = phoneTitile
    }
    
    func clearFields() {
        firstCodeSquare.text = ""
        secondCodeSquare.text = ""
        thirdCodeSquare.text = ""
        fourthCodeSquare.text = ""
        fifthCodeSquare.text = ""
        sixthCodeSquare.text = ""
    }
}

// MARK: - private methods
private extension VerificationViewController {
    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        addTitlePhone()
        setupSubviews()
        setupConstraints()
    }
    
    func addTitlePhone() {
        presenter?.getPhoneNumber()
    }
    
    func getCode() -> [String?] {
        return [firstCodeSquare.text, secondCodeSquare.text, thirdCodeSquare.text,
                fourthCodeSquare.text, fifthCodeSquare.text, sixthCodeSquare.text]
    }
    
    func invalidCodeAllert() -> UIAlertController {
        lazy var allert = UIAlertController()
        allert = .init(title: "Неверный код из смс",
                       message: "Пожалуйста, проверьте правильность заполнения полей", preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Ввести код еще раз", style: .default, handler: { _ in
            self.firstCodeSquare.becomeFirstResponder()
            self.firstCodeSquare.stateForTextField(with: .selected)
        }))
        return allert
    }
    
    func setupSubviews() {
        let subViewws = [messageImageView, phoneImageView,
                         messagePhoneLabel, messagePhoneDescriptionLabel,
                         firstCodeSquare, secondCodeSquare, thirdCodeSquare,
                         fourthCodeSquare, fifthCodeSquare, sixthCodeSquare,
                         verifyButton]
        view.myAddSubViews(from: subViewws)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            messageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            messageImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            messageImageView.widthAnchor.constraint(equalToConstant: 50),
            messageImageView.heightAnchor.constraint(equalToConstant: 30),
            
            phoneImageView.topAnchor.constraint(equalTo: messageImageView.topAnchor, constant: 10),
            phoneImageView.trailingAnchor.constraint(equalTo: messageImageView.leadingAnchor, constant: 30),
            
            messagePhoneLabel.topAnchor.constraint(equalTo: phoneImageView.bottomAnchor, constant: 5),
            messagePhoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messagePhoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messagePhoneDescriptionLabel.topAnchor.constraint(equalTo: messagePhoneLabel.bottomAnchor, constant: 10),
            messagePhoneDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messagePhoneDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstCodeSquare.topAnchor.constraint(equalTo: messagePhoneDescriptionLabel.bottomAnchor, constant: 40),
            firstCodeSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            firstCodeSquare.widthAnchor.constraint(equalToConstant: 35),
            firstCodeSquare.heightAnchor.constraint(equalToConstant: 40),
            
            secondCodeSquare.topAnchor.constraint(equalTo: messagePhoneDescriptionLabel.bottomAnchor, constant: 40),
            secondCodeSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            secondCodeSquare.widthAnchor.constraint(equalToConstant: 35),
            secondCodeSquare.heightAnchor.constraint(equalToConstant: 40),
            
            thirdCodeSquare.topAnchor.constraint(equalTo: messagePhoneDescriptionLabel.bottomAnchor, constant: 40),
            thirdCodeSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            thirdCodeSquare.widthAnchor.constraint(equalToConstant: 35),
            thirdCodeSquare.heightAnchor.constraint(equalToConstant: 40),
            
            fourthCodeSquare.topAnchor.constraint(equalTo: messagePhoneDescriptionLabel.bottomAnchor, constant: 40),
            fourthCodeSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            fourthCodeSquare.widthAnchor.constraint(equalToConstant: 35),
            fourthCodeSquare.heightAnchor.constraint(equalToConstant: 40),
            
            fifthCodeSquare.topAnchor.constraint(equalTo: messagePhoneDescriptionLabel.bottomAnchor, constant: 40),
            fifthCodeSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            fifthCodeSquare.widthAnchor.constraint(equalToConstant: 35),
            fifthCodeSquare.heightAnchor.constraint(equalToConstant: 40),
            
            sixthCodeSquare.topAnchor.constraint(equalTo: messagePhoneDescriptionLabel.bottomAnchor, constant: 40),
            sixthCodeSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            sixthCodeSquare.widthAnchor.constraint(equalToConstant: 35),
            sixthCodeSquare.heightAnchor.constraint(equalToConstant: 40),
            
            verifyButton.topAnchor.constraint(greaterThanOrEqualTo: sixthCodeSquare.bottomAnchor,
                                              constant: 50),
            verifyButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor,
                                                 constant: -80),
            verifyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verifyButton.widthAnchor.constraint(equalToConstant: 220),
            verifyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
