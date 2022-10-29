//
//  UITableViewCell+Extensions.swift
//  NY Times Articles
//
//  Created by Najeeb on 29/10/2022.
//

import UIKit

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
