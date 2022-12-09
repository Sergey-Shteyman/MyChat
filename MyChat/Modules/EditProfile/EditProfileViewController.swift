//
//  EditProfileViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

import UIKit

// MARK: - EditProfileDisplayLogic
protocol EditProfileDisplayLogic: ViewController {
    func updateView(_ viewModel: ProfileViewModel)
    func popToPreviousPage()
    func showEditProfileError()
}

// MARK: - EditProfileViewController
final class EditProfileViewController: ViewController {
    
    var presenter: EditProfilePresentationLogic?
    
    private let robotoFont = RobotoFont.self
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private lazy var avatarButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 59
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(self, action: #selector(didTapAvatarButton), for: .touchDown)
        return button
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.medium, size: 26)
        label.textAlignment = .center
        label.text = "Sergey Shteyman"
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        label.font = UIFont(name: UIFont.Roboto.thin.rawValue, size: 25)
        label.textAlignment = .center
        label.text = "+7 9109664445"
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    
    private lazy var aboutTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.font = UIFont(name: robotoFont.light, size: 17)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 0.2
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.text = "Расскажите о себе"
        textView.textColor = .gray
        textView.delegate = self
        return textView
    }()
    
    private lazy var descriptionAbout: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.light, size: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = "Краткая информация"
        return label
    }()

    private lazy var cityTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Город проживания"
        textField.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 22)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.changeStateBottomLine(with: .normal)
//        textField.delegate = self
        return textField
    }()
    
    private lazy var bithdateTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Дата рождения"
        textField.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 22)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.changeStateBottomLine(with: .normal)
//        textField.delegate = self
        return textField
    }()
    
    private lazy var horoscopeTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Гороскоп"
        textField.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 22)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.changeStateBottomLine(with: .normal)
//        textField.delegate = self
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViewController()
        presenter?.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter?.viewWillDisappear()
    }
    
    @objc
    private func didTapAvatarButton() {
        print(#function)
    }
}

// MARK: - EditProfileDisplayLogic impl
extension EditProfileViewController: EditProfileDisplayLogic {
    
    func popToPreviousPage() {
        navigationController?.popViewController(animated: true)
    }
    
    func updateView(_ viewModel: ProfileViewModel) {
        
    }

    func showEditProfileError() {
        
    }
}

// MARK: - UITextViewDelegate impl
extension EditProfileViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if aboutTextView.text == "Расскажите о себе" {
            setupPlaceHolderForTextView("", .black)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if aboutTextView.text.isEmpty {
            setupPlaceHolderForTextView("Расскажите о себе", .gray)
        }
    }
}

// MARK: - Private methods
private extension EditProfileViewController {
    
    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        setupScrollView()
        setupConstraints()
    }
    
    func setupPlaceHolderForTextView(_ text: String,
                                     _ textColor: UIColor,
                                     _ alignment: NSTextAlignment = .left) {
        aboutTextView.text = text
        aboutTextView.textColor = textColor
        aboutTextView.textAlignment = alignment
    }
    
    func setupScrollView() {
        view.myAddSubView(scrollView)
        addViewwsOnScrollView()
        scrollView.contentSize = CGSize(width: 0, height: horoscopeTextField.frame.maxY + 20)
        setupScrollViewConstraints()
    }
    
    func addViewwsOnScrollView() {
        let views = [
            avatarButton,
            usernameLabel,
            phoneLabel,
            aboutTextView,
            descriptionAbout,
            phoneLabel,
            cityTextField,
            bithdateTextField,
            horoscopeTextField
        ]
        scrollView.addSubViewOnScrollVeiw(for: views, scrollView: scrollView)
    }
    
    func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor)
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarButton.topAnchor.constraint(lessThanOrEqualTo: scrollView.topAnchor, constant: 20),
            avatarButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarButton.widthAnchor.constraint(equalToConstant: 120),
            avatarButton.heightAnchor.constraint(equalToConstant: 120),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarButton.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            phoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            aboutTextView.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 40),
            aboutTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            aboutTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            aboutTextView.heightAnchor.constraint(equalToConstant: 65),
            
            descriptionAbout.leadingAnchor.constraint(equalTo: aboutTextView.leadingAnchor),
            descriptionAbout.bottomAnchor.constraint(equalTo: aboutTextView.topAnchor, constant: -5),
            
            cityTextField.topAnchor.constraint(equalTo: aboutTextView.bottomAnchor, constant: 40),
            cityTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            bithdateTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 40),
            bithdateTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bithdateTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            horoscopeTextField.topAnchor.constraint(equalTo: bithdateTextField.bottomAnchor, constant: 40),
            horoscopeTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            horoscopeTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            horoscopeTextField.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor, constant: -30)
        ])
    }
}
