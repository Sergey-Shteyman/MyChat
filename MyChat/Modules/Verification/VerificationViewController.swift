//
//  VerificationViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 03.12.2022.
//

import UIKit


// MARK: - VerificationDisplayLogic
protocol VerificationDisplayLogic: AnyObject {
    
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
//        textField.addTarget(self,
//                            action: #selector(firstCodeSquareChanged),
//                            for: .editingChanged)
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
//        textField.addTarget(self,
//                            action: #selector(firstCodeSquareChanged),
//                            for: .editingChanged)
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
//        textField.addTarget(self,
//                            action: #selector(firstCodeSquareChanged),
//                            for: .editingChanged)
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
//        textField.addTarget(self,
//                            action: #selector(firstCodeSquareChanged),
//                            for: .editingChanged)
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
//        textField.addTarget(self,
//                            action: #selector(firstCodeSquareChanged),
//                            for: .editingChanged)
        return textField
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        firstCodeSquare.becomeFirstResponder()
        firstCodeSquare.stateForTextField(with: .selected)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTitle(phoneCode: "+7", phone: "232342234")
        setupViewController()
    }
    
    @objc
    func firstCodeSquareChanged() {
        if firstCodeSquare.text?.count == 1 {
            firstCodeSquare.resignFirstResponder()
            firstCodeSquare.stateForTextField(with: .normal)
        }
    }
    
}

// MARK: - VerificationDisplayLogic
extension VerificationViewController: VerificationDisplayLogic {
    
    // TODO: - presenter
    func setupTitle(phoneCode: String, phone: String) {
        phoneTitile.text = "\(phoneCode) \(phone)"
        self.navigationItem.titleView = phoneTitile
    }
}

// MARK: - private methods
private extension VerificationViewController {
    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        let subViewws = [messageImageView, phoneImageView,
                         messagePhoneLabel, messagePhoneDescriptionLabel,
                         firstCodeSquare, secondCodeSquare, thirdCodeSquare,
                         fourthCodeSquare, fifthCodeSquare, sixthCodeSquare]
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
            sixthCodeSquare.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
