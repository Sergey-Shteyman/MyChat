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
    func showEditProfileError()
    func presentPhotoActionSheet()
    func configuredHoroscopeLabel(_ horoscope: String)
    func displayDate(_ date: String)
    func updateAvatar(_ image: UIImage?)
}

// MARK: - EditProfileViewController
final class EditProfileViewController: ViewController {
    
    var presenter: EditProfilePresentationLogic?
    
    private let robotoFont = RobotoFont.self
    private let editProfile = EditProfilePage.self
    private let locale = LocaleIdentifires.self
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageVeiw = UIImageView()
        imageVeiw.layer.cornerRadius = 59
        imageVeiw.layer.borderWidth = 1
        imageVeiw.layer.borderColor = UIColor.gray.cgColor
        imageVeiw.contentMode = .scaleAspectFit
        imageVeiw.layer.masksToBounds = true
        imageVeiw.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfileAvatar))
        imageVeiw.addGestureRecognizer(gesture)
        return imageVeiw
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
        textView.text = editProfile.abotUser
        textView.delegate = self
        return textView
    }()
    
    private lazy var descriptionAbout: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.light, size: 14)
        label.textColor = .gray
        label.textAlignment = .center
        label.text = editProfile.aboutUserDescription
        return label
    }()

    private lazy var cityTextField: TextField = {
        let textField = TextField()
        textField.placeholder = editProfile.city
        textField.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 22)
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.done
        textField.backgroundColor = .clear
        textField.changeStateBottomLine(with: .normal)
        textField.delegate = self
        return textField
    }()
    
    private lazy var birthdayTextField: TextField = {
        let textField = TextField()
        textField.placeholder = editProfile.birthday
        textField.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 22)
        textField.clearButtonMode = .whileEditing
        textField.backgroundColor = .clear
        textField.changeStateBottomLine(with: .normal)
        textField.delegate = self
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        datepicker.locale = Locale(identifier: locale.loacaleRu)
        datepicker.preferredDatePickerStyle = .wheels
        datepicker.addTarget(self, action: #selector(dateHasChanged), for: .valueChanged)
        return datepicker
    }()
    
    private lazy var horoscopeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 17)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.6
        label.layer.borderColor = UIColor.systemBlue.cgColor
        label.backgroundColor = .systemGray6
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        birthdayTextField.inputView = datePicker
        setupViewController()
        presenter?.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        presenter?.viewWillDisappear(
            status: aboutTextView.text,
            city: cityTextField.text,
            birthday: birthdayTextField.text,
            avatar: avatarImageView.image
        )
    }
    
    @objc
    private func didTapChangeProfileAvatar() {
        presenter?.changeAvatar()
    }
    
    @objc
    private func dateHasChanged() {
        presenter?.setDate(datePicker.date)
    }
}

// MARK: - EditProfileDisplayLogic impl
extension EditProfileViewController: EditProfileDisplayLogic {
    
    func updateAvatar(_ image: UIImage?) {
        guard let image = image else {
            avatarImageView.image = UIImage(systemName: "person")
            return
        }
        avatarImageView.image = image
    }
    
    func displayDate(_ date: String) {
        birthdayTextField.text = date
    }
    
    func presentPhotoActionSheet() {
        let actionSheet = configuredActionSheet()
        present(actionSheet, animated: true)
    }
    
    func updateView(_ viewModel: ProfileViewModel) {
        let horoscope = viewModel.horoscope
        usernameLabel.text = viewModel.name
        phoneLabel.text = viewModel.phone
        aboutTextView.text = viewModel.status
        cityTextField.text = viewModel.city
        birthdayTextField.text = viewModel.birthday
        horoscopeLabel.text = horoscope.rawValue
    }
    
    func configuredHoroscopeLabel(_ horoscope: String) {
        horoscopeLabel.text = horoscope
    }

    func showEditProfileError() {
        
    }
}

// MARK: - UITextFieldDelegate impl
extension EditProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case cityTextField:
            textField.resignFirstResponder()
            return true
        default:
            return false
        }
    }
}

// MARK: - UITextViewDelegate impl
extension EditProfileViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if aboutTextView.text == editProfile.abotUser {
            setupPlaceHolderForTextView("", .black)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if aboutTextView.text.isEmpty {
            setupPlaceHolderForTextView(editProfile.abotUser, .gray)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate Impl
extension EditProfileViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        presenter?.didUpdateAvatar(selectedImage)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: - UINavigationControllerDelegate Impl
extension EditProfileViewController: UINavigationControllerDelegate {
    
}

// MARK: - Private methods
private extension EditProfileViewController {
    
    func setupViewController() {
        view.addTapGestureToHideKeyboard()
        setupScrollView()
        setupConstraints()
    }
    
    func presentCamera() {
        let viewController = UIImagePickerController()
        viewController.sourceType = .camera
        viewController.delegate = self
        viewController.allowsEditing = true
        present(viewController, animated: true)
    }
    
    func presentPhotoPicker() {
        let viewController = UIImagePickerController()
        viewController.sourceType = .photoLibrary
        viewController.delegate = self
        viewController.allowsEditing = true
        present(viewController, animated: true)
    }
    
    func configuredActionSheet() -> UIAlertController {
        let actionSheet = UIAlertController(
            title: editProfile.titleActionSheet,
            message: editProfile.messageActionSheet,
            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: editProfile.exitActionSheet, style: .cancel))
        actionSheet.addAction(UIAlertAction(title: editProfile.takePhotoActionSheet,
                                            style: .default, handler: { [weak self] _ in
            self?.presentCamera()
        }))
        actionSheet.addAction(UIAlertAction(title: editProfile.chousePhotoActionSheet,
                                            style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        }))
        return actionSheet
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
        scrollView.contentSize = CGSize(width: 0, height: horoscopeLabel.frame.maxY + 20)
        setupScrollViewConstraints()
    }
    
    func addViewwsOnScrollView() {
        let views = [
            avatarImageView,
            usernameLabel,
            phoneLabel,
            aboutTextView,
            descriptionAbout,
            phoneLabel,
            cityTextField,
            birthdayTextField,
            horoscopeLabel,
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
            avatarImageView.topAnchor.constraint(lessThanOrEqualTo: scrollView.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
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
            
            birthdayTextField.topAnchor.constraint(equalTo: cityTextField.bottomAnchor, constant: 40),
            birthdayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            birthdayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            horoscopeLabel.topAnchor.constraint(equalTo: birthdayTextField.bottomAnchor, constant: 40),
            horoscopeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            horoscopeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            horoscopeLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.keyboardLayoutGuide.topAnchor, constant: -30),
            horoscopeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
