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
    func clearFields()
    func filedsResignSelection()
    func showVerificationError()
}

// MARK: - VerificationViewController
final class VerificationViewController: ViewController {

    private let robotoFont = RobotoFont.self
    private let verify = VerificationPage.self
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
    
    private lazy var firstCodeSquare: UITextField = {
        let textField = UITextField()
        textField.setDefauldOTP(fontSize: 23)
        textField.delegate = self
        textField.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        return textField
    }()
    
    private lazy var secondCodeSquare: UITextField = {
        let textField = UITextField()
        textField.setDefauldOTP(fontSize: 23)
        textField.delegate = self
        textField.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        return textField
    }()
    
    private lazy var thirdCodeSquare: UITextField = {
        let textField = UITextField()
        textField.setDefauldOTP(fontSize: 23)
        textField.delegate = self
        textField.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        return textField
    }()
    
    private lazy var fourthCodeSquare: UITextField = {
        let textField = UITextField()
        textField.setDefauldOTP(fontSize: 23)
        textField.delegate = self
        textField.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        return textField
    }()
    
    private lazy var fifthCodeSquare: UITextField = {
        let textField = UITextField()
        textField.setDefauldOTP(fontSize: 23)
        textField.delegate = self
        textField.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        return textField
    }()
    
    private lazy var sixthCodeSquare: UITextField = {
        let textField = UITextField()
        textField.setDefauldOTP(fontSize: 23)
        textField.delegate = self
        textField.addTarget(self, action: #selector(changeCharacter), for: .editingChanged)
        return textField
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 20)
        button.setTitle(verify.nextButton, for: .normal)
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
        presenter?.viewDidLoad()
    }
    
    @objc
    func buttonIsTapped() {
        let codeInFields = getCode()
        presenter?.didTapVerifyButton(fields: codeInFields)
    }
    
    @objc
    func changeCharacter(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if text.count == 1 {
            switch textField {
            case firstCodeSquare:
                secondCodeSquare.becomeFirstResponder()
            case secondCodeSquare:
                thirdCodeSquare.becomeFirstResponder()
            case thirdCodeSquare:
                fourthCodeSquare.becomeFirstResponder()
            case fourthCodeSquare:
                fifthCodeSquare.becomeFirstResponder()
            case fifthCodeSquare:
                sixthCodeSquare.becomeFirstResponder()
            case sixthCodeSquare:
                sixthCodeSquare.resignFirstResponder()
            default:
                break
            }
        } else if text.isEmpty {
            switch textField {
            case sixthCodeSquare:
                fifthCodeSquare.becomeFirstResponder()
            case fifthCodeSquare:
                fourthCodeSquare.becomeFirstResponder()
            case fourthCodeSquare:
                thirdCodeSquare.becomeFirstResponder()
            case thirdCodeSquare:
                secondCodeSquare.becomeFirstResponder()
            case secondCodeSquare:
                firstCodeSquare.becomeFirstResponder()
            default:
                break
            }
        }
    }
}

// MARK: - UITextFieldDelegate Impl
extension VerificationViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
              let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                   return false
           }
           let substringToReplace = textFieldText[rangeOfTextToReplace]
           let count = textFieldText.count - substringToReplace.count + string.count
           return count <= 1
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case firstCodeSquare:
            firstCodeSquare.stateForTextField(with: .selected)
        case secondCodeSquare:
            secondCodeSquare.stateForTextField(with: .selected)
        case thirdCodeSquare:
            thirdCodeSquare.stateForTextField(with: .selected)
        case fourthCodeSquare:
            fourthCodeSquare.stateForTextField(with: .selected)
        case fifthCodeSquare:
            fifthCodeSquare.stateForTextField(with: .selected)
        case sixthCodeSquare:
            sixthCodeSquare.stateForTextField(with: .selected)
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstCodeSquare:
            firstCodeSquare.stateForTextField(with: .normal)
        case secondCodeSquare:
            secondCodeSquare.stateForTextField(with: .normal)
        case thirdCodeSquare:
            thirdCodeSquare.stateForTextField(with: .normal)
        case fourthCodeSquare:
            fourthCodeSquare.stateForTextField(with: .normal)
        case fifthCodeSquare:
            fifthCodeSquare.stateForTextField(with: .normal)
        case sixthCodeSquare:
            sixthCodeSquare.stateForTextField(with: .normal)
        default:
            break
        }
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
    
    func clearFields() {
        firstCodeSquare.text = ""
        secondCodeSquare.text = ""
        thirdCodeSquare.text = ""
        fourthCodeSquare.text = ""
        fifthCodeSquare.text = ""
        sixthCodeSquare.text = ""
    }
    
    func filedsResignSelection() {
        firstCodeSquare.stateForTextField(with: .normal)
        secondCodeSquare.stateForTextField(with: .normal)
        thirdCodeSquare.stateForTextField(with: .normal)
        fourthCodeSquare.stateForTextField(with: .normal)
        fifthCodeSquare.stateForTextField(with: .normal)
        sixthCodeSquare.stateForTextField(with: .normal)
    }
}

// MARK: - private methods
private extension VerificationViewController {
    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        setupSubviews()
        setupConstraints()
    }
    
    func getCode() -> [String?] {
        return [firstCodeSquare.text, secondCodeSquare.text, thirdCodeSquare.text,
                fourthCodeSquare.text, fifthCodeSquare.text, sixthCodeSquare.text]
    }
    
    func invalidCodeAllert() -> UIAlertController {
        lazy var allert = UIAlertController()
        allert = .init(title: verify.wrongSMS,
                       message: verify.checkCorrectFields, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: verify.inputOneMoreCode, style: .default, handler: {[weak self] _ in
            self?.presenter?.prepareScreen()
            self?.firstCodeSquare.becomeFirstResponder()
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
