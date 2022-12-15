//
//  VerificationViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 03.12.2022.
//

import UIKit


// MARK: - VerificationDisplayLogic
protocol VerificationDisplayLogic: ViewController {
    func showInvalidCodeAllert()
    func setupPhoneNumberTitle(phoneCode: String, phone: String)
    func showVerificationError()
}

// MARK: - VerificationViewController
final class VerificationViewController: ViewController {

    private let robotoFont = RobotoFont.self
    private let verify = VerificationConstants.self
    private let messageImage = Images.message.rawValue
    private let phoneImage = Images.iphone.rawValue
    
    var presenter: VerificationPresentationLogic?
    
    private lazy var phoneTitile: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 24)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: messageImage)?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    private lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: phoneImage)
        return imageView
    }()
    
    private lazy var messagePhoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: 25)
        label.textAlignment = .center
        label.text = verify.checkYorSMS
        return label
    }()
    
    private lazy var messagePhoneDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 15)
        label.textAlignment = .center
        label.text = verify.smsDescription
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var codeView = make(CodeView()) { myCodeView in
        myCodeView.delegate = self
        myCodeView.setupTextFields(count: 6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewController()
        presenter?.viewDidLoad()
    }
}

// MARK: - VerificationDisplayLogic impl
extension VerificationViewController: VerificationDisplayLogic {
    
    func showVerificationError() {
        print(#function)
    }
    
    func showInvalidCodeAllert() {
        present(invalidCodeAllert(), animated: true)
    }
    
    func setupPhoneNumberTitle(phoneCode: String, phone: String) {
        phoneTitile.text = "\(phoneCode) \(phone)"
        self.navigationItem.titleView = phoneTitile
    }
}

// MARK: - CodeViewDelegate
extension VerificationViewController:  CodeViewDelegate {
    
    func didChange(_ code: String) {
        presenter?.completeCode(code)
    }
}

// MARK: - private methods
private extension VerificationViewController {
    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        setupSubviews()
        setupConstraints()
    }
    
    func invalidCodeAllert() -> UIAlertController {
        lazy var allert = UIAlertController()
        allert = .init(title: verify.wrongSMS,
                       message: verify.checkCorrectFields, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: verify.inputOneMoreCode, style: .default))
        return allert
    }
    
    func setupSubviews() {
        let subViewws = [
            messageImageView,
            phoneImageView,
            messagePhoneLabel,
            messagePhoneDescriptionLabel,
            codeView,
        ]
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
            
            codeView.topAnchor.constraint(equalTo: messagePhoneDescriptionLabel.bottomAnchor, constant: 50),
            codeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeView.heightAnchor.constraint(equalToConstant: 50),
            codeView.widthAnchor.constraint(equalToConstant: 283)
        ])
    }
}
