//
//  InputAccessoryView.swift
//  MyChat
//
//  Created by Сергей Штейман on 31.12.2022.
//

import UIKit


// MARK: - InputAccessoryView
final class InputAccessoryView: UIView {
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: UIView.noIntrinsicMetric, height: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
