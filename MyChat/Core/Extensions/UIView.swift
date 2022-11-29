//
//  UIView.swift
//  MyChat
//
//  Created by Сергей Штейман on 29.11.2022.
//

import UIKit

extension UIView {
    
    func myAddSubView(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
    }
    
    func myAddSubViews(from array: [UIView]) {
        for view in array {
            myAddSubView(view)
        }
    }
    
    func addLetterSpacing(label: UILabel, spacing: CGFloat) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: label.text ?? " ")
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: spacing,
                                      range: NSRange(location: 0,
                                                     length: attributedString.length))
        return attributedString
    }
    
    func addTapGestureToHideKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }
}
