//
//  UIView+Extensions.swift
//  NY Times Articles
//
//  Created by Najeeb on 25/10/2022.
//

import UIKit

extension UIView {
    
    func setCornerRadius(_ r : CGFloat, andClipContent clip: Bool = false) {
        layer.cornerRadius = r
        layer.masksToBounds = clip
    }
    
    func setCornerRadius(_ r: CGFloat, forCorners corners: CACornerMask, andClipContent clip: Bool = false) {
        layer.maskedCorners = corners
        setCornerRadius(r, andClipContent: clip)
    }
}
