//
//  SplashViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 06.12.2022.
//

import UIKit

protocol SplashDisplayLogic: ViewController {
    func showError()
}

final class SplashViewController: ViewController {

    var presenter: SplashPresentationLogic?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        presenter?.viewDidLoad()
    }

    private func setupViewController() {}
}

extension SplashViewController: SplashDisplayLogic {
    func showError() {
        print(#function)
    }
}
