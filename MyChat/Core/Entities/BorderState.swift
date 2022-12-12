//
//  BorderState.swift
//  MyChat
//
//  Created by Сергей Штейман on 04.12.2022.
//

import UIKit

enum BorderState {
    case normal
    case selected
    
    var color: UIColor {
        switch self {
        case .normal:
            return .gray
        case .selected:
            return .systemBlue
        }
    }
}
