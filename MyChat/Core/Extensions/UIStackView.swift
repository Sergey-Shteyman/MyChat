//
//  UIStackView.swift
//  MyChat
//
//  Created by Сергей Штейман on 07.12.2022.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
