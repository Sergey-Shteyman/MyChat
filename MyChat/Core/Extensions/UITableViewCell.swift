//
//  UITableViewCell.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//

import UIKit

extension UITableViewCell {
    
    class var myReuseId: String {
        return String(describing: Self.self)
    }
}
