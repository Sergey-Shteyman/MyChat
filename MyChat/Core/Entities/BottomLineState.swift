//
//  BottomLineState.swift
//  MyChat
//
//  Created by Сергей Штейман on 30.11.2022.
//

import UIKit

enum BottomLineState {
    case normal
    case error
    
    var color: UIColor {
        switch self {
        case .normal:
            return .systemBlue
        case .error:
            return .red
        }
    }
}
