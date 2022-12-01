//
//  UITextField.swift
//  MyChat
//
//  Created by Сергей Штейман on 29.11.2022.
//

import UIKit

extension TextField {
    
    func setupLeftSideImage(with image: UIImage) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 30, height: 20))
        imageView.image = image
        let imageViewContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 55, height: 40))
        imageViewContainerView.addSubview(imageView)
        leftView = imageViewContainerView
        leftViewMode = .always
        self.tintColor = .lightGray
    }
}
