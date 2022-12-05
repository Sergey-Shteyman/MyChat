//
//  UITextField.swift
//  MyChat
//
//  Created by Сергей Штейман on 04.12.2022.
//

import UIKit

extension UITextField {
    
    func stateForTextField(with state: BorderState) {
        self.layer.borderColor = state.color.cgColor
    }
    
    func setDefauldOTP(fontSize: CGFloat) {
        self.keyboardType = UIKeyboardType.numberPad
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = 6
        self.textAlignment = .center
        self.font = UIFont(name: UIFont.Roboto.medium.rawValue, size: fontSize)
    }
}
