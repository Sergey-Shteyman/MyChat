//
//  UITableView.swift
//  MyChat
//
//  Created by Сергей Штейман on 11.12.2022.
//

import UIKit

extension UITableView {
    
    func myRegister(_ cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.myReuseId)
    }
    
    func myDequeueReusableCell<T: UITableViewCell>(type: T.Type, indePath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.myReuseId, for: indePath) as? T else {
            fatalError("\(String(describing: type)) not found")
        }
        return cell
    }
}
