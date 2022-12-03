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
    
    var presenter: VerificationPresentationLogic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

// MARK: - VerificationDisplayLogic
extension VerificationViewController: VerificationDisplayLogic {
    
}
