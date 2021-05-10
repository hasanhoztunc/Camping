//
//  UIView+Extensions.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

extension UIView {
    
    var cornerRadius: CGFloat {
        get {
            self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
