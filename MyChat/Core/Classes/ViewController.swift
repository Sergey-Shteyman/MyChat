//
//  ViewController.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.tintColor = .gray
        return activityIndicator
    }()
    
    func showLoading() {
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
    }
    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
