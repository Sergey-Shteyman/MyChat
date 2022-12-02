//
//  AuthViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 02.12.2022.
//

import UIKit


// MARK: - DisplayAuthLogic
protocol DisplayAuthLogic: AnyObject {
    
}

// MARK: - AuthViewController
final class AuthViewController: UIViewController {
    
    var presenter: PresentationAuthLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

// MARK: - DisplayAuthLogic Impl
extension AuthViewController: DisplayAuthLogic {
    
}
