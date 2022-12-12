//
//  UIScrollView.swift
//  MyChat
//
//  Created by Сергей Штейман on 29.11.2022.
//

import UIKit

extension UIScrollView {
    
    func addSubViewOnScrollVeiw(for views: [UIView], scrollView: UIScrollView) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(view)
        }
    }
}
