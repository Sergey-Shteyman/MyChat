//
//  ProfileViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit

// MARK: - ProfileDisplayLogic
protocol ProfileDisplayLogic: ViewController {
    func updateView(_ viewModel: ProfileViewModel)
    func showProfileError()
}

// MARK: - ProfileViewController
final class ProfileViewController: ViewController {
    
    var presenter: ProfilePresentationLogic?
    
    private let robotoFont = RobotoFont.self
    private let profile = ProfilePage.self

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private lazy var avatarImageView: UIImageView = {
        let imageVeiw = UIImageView()
        imageVeiw.image = UIImage(systemName: profile.personImage)
        imageVeiw.layer.cornerRadius = 59
        imageVeiw.layer.borderWidth = 1
        imageVeiw.layer.borderColor = UIColor.gray.cgColor
        imageVeiw.contentMode = .scaleAspectFit
        imageVeiw.layer.masksToBounds = true
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
    
    private lazy var aboutLabel: UILabel = {
        let aboutLabel = UILabel()
        aboutLabel.backgroundColor = .systemGray6
        aboutLabel.font = UIFont(name: robotoFont.light, size: 17)
        aboutLabel.layer.cornerRadius = 10
        aboutLabel.layer.borderWidth = 0.2
        aboutLabel.layer.borderColor = UIColor.gray.cgColor
        aboutLabel.text = profile.abotUser
        aboutLabel.textColor = .gray
        aboutLabel.textAlignment = .center
        aboutLabel.numberOfLines = 0
        aboutLabel.lineBreakMode = .byWordWrapping
        return aboutLabel
    }()
    
    private lazy var descriptionAbout: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.light, size: 14)
        label.textColor = .gray
        label.textAlignment = .left
        label.text = profile.aboutUserDescription
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = profile.city
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 17)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.gray.cgColor
        label.backgroundColor = .systemGray6
        return label
    }()
    
    private lazy var bithdateLabel: UILabel = {
        let label = UILabel()
        label.text = profile.birthday
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 17)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.gray.cgColor
        label.backgroundColor = .systemGray6
        return label
    }()
    
    private lazy var horoscopeLabel: UILabel = {
        let label = UILabel()
        label.text = profile.horoscope
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont(name: UIFont.Roboto.light.rawValue, size: 17)
        label.backgroundColor = .clear
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 0.2
        label.layer.borderColor = UIColor.gray.cgColor
        label.backgroundColor = .systemGray6
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupViewController()
        presenter?.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc
    private func didTapEditButton() {
        presenter?.didTapEditButton()
    }
    
    @objc
    private func editButtontapped() {
        print(#function)
    }
}

// MARK: - ProfileDisplayLogic Impl
extension ProfileViewController: ProfileDisplayLogic {
    
    func updateView(_ viewModel: ProfileViewModel) {
        
    }

    func showProfileError() {
        
    }
}

// MARK: - Private methods
private extension ProfileViewController {
    
    func setupViewController() {
        view.backgroundColor = .white
        setupScrollView()
        setupEditBarItem()
        setupConstaints()
    }
    
    func setupEditBarItem() {
        let editButton = UIBarButtonItem(title: profile.editButton,
                                         style: .done, target: self, action: #selector(editButtontapped))
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    func setupScrollView() {
        view.myAddSubView(scrollView)
        addViewsOnScrollView()
        scrollView.contentSize = CGSize(width: 0, height: horoscopeLabel.frame.maxY + 20)
    }
    
    func addViewsOnScrollView() {
        let subViews = [
            avatarImageView,
            usernameLabel,
            phoneLabel,
            aboutLabel,
            descriptionAbout,
            cityLabel,
            bithdateLabel,
            horoscopeLabel
        ]
        scrollView.addSubViewOnScrollVeiw(for: subViews, scrollView: scrollView)
    }
    
    func setupConstaints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),
            
            avatarImageView.topAnchor.constraint(lessThanOrEqualTo: scrollView.topAnchor, constant: 20),
            avatarImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 120),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            phoneLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            phoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            aboutLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 40),
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            aboutLabel.heightAnchor.constraint(equalToConstant: 65),
            
            descriptionAbout.leadingAnchor.constraint(equalTo: aboutLabel.leadingAnchor),
            descriptionAbout.bottomAnchor.constraint(equalTo: aboutLabel.topAnchor, constant: -5),
            
            cityLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 30),
            cityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            
            bithdateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30),
            bithdateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bithdateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bithdateLabel.heightAnchor.constraint(equalToConstant: 40),
            
            horoscopeLabel.topAnchor.constraint(equalTo: bithdateLabel.bottomAnchor, constant: 30),
            horoscopeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            horoscopeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            horoscopeLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
