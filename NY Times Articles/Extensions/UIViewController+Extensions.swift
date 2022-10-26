//
//  UIViewController+Extensions.swift
//  NY Times Articles
//
//  Created by Najeeb on 26/10/2022.
//

import UIKit

extension UIViewController {
    
    static var storyboardId: String {
        return String(describing: self)
    }
    
    static func instantiate(from storyboardName: UIStoryboard.Name) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: storyboardId) as! Self
    }
    
    static func instantiate(from storyboardName: UIStoryboard.Name,
                            creator: @escaping ((NSCoder) -> UIViewController)) -> Self {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(identifier: storyboardId, creator: creator) as! Self
    }
    
}

