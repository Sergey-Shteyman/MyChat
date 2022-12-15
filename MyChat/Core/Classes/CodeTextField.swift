//
//  CodeTextField.swift
//  MyChat
//
//  Created by Сергей Штейман on 15.12.2022.
//

import UIKit


// MARK: - CodeTextFieldDelegate
protocol CodeTextFieldDelegate: AnyObject{
    func textFieldDidDelete(_ textField: UITextField)
}

// MARK: - CodeTextField
final class CodeTextField: UITextField {
    
    weak var myDelegate: CodeTextFieldDelegate?
    
    override func deleteBackward() {
        super.deleteBackward()
        myDelegate?.textFieldDidDelete(self)
    }
    
    override func closestPosition(to point: CGPoint) -> UITextPosition? {
        let beginning = self.beginningOfDocument
        let end = self.position(from: beginning, offset: self.text?.count ?? 0)
        return end
    }
}
