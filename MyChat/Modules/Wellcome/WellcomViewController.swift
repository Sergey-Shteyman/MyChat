//
//  WellcomViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 02.12.2022.
//

import UIKit

// MARK: - WellcomDisplayLogic
protocol WellcomDisplayLogic: ViewController {
    func routTo(_ viewController: UIViewController)
}

// MARK: - WellcomViewController
final class WellcomViewController: ViewController {
    
    var presenter: WellcomPresentationLogic?
    
    private let robotoFont = RobotoFont.self
    private let welcome = WelcomePage.self
    
    private lazy var nameApp: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.medium, size: 28)
        label.textAlignment = .center
        label.text = welcome.nameApp
        return label
    }()
    
    private lazy var producedByLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.regular, size: 14)
        label.textAlignment = .center
        label.text = welcome.producedBy
        return label
    }()
    
    private lazy var nameAutor: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: robotoFont.regular, size: 16)
        label.text = welcome.nameAutor
        label.textAlignment = .center
        return label
    }()
    
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: UIFont.Roboto.regular.rawValue, size: 20)
        button.setTitle(welcome.startButton, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(buttonIsTapped), for: .touchDown)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
    
    @objc
    func buttonIsTapped() {
        presenter?.didTapButton()
    }
}

// MARK: - WellcomDisplayLogic Impl
extension WellcomViewController: WellcomDisplayLogic {
    
    func routTo(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private methods
private extension WellcomViewController {
    
    func setupViewController() {
        view.backgroundColor = .white
        addSubViewws()
        addConstraints()
    }
    
    func addSubViewws() {
        let subviews = [nameApp, producedByLabel, nameAutor, startButton]
        view.myAddSubViews(from: subviews)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            nameApp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            nameApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            producedByLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            producedByLabel.topAnchor.constraint(equalTo: nameApp.bottomAnchor, constant: 10),
            
            nameAutor.topAnchor.constraint(equalTo: producedByLabel.bottomAnchor, constant: 10),
            nameAutor.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 220),
            startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
