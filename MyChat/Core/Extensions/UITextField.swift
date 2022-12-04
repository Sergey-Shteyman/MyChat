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
}
