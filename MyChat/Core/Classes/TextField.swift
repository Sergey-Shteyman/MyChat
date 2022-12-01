//
//  TextField.swift
//  MyChat
//
//  Created by Сергей Штейман on 29.11.2022.
//

import UIKit

// MARK: - TextField
final class TextField: UITextField {
    
    let bottomLine = CALayer()
    var colorLine: UIColor = .systemBlue
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLine.removeFromSuperlayer()
        addBottomLine(with: colorLine)
    }
    
    func changeStateBottomLine(with state: BottomLineState) {
        addBottomLine(with: state.color)
    }
}

// MARK: - methods
private extension TextField {
    
    func addBottomLine(with color: UIColor) {
        colorLine = color
        bottomLine.backgroundColor = colorLine.cgColor
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height + 12, width: self.frame.width, height: 1)
        layer.addSublayer(bottomLine)
    }
}
