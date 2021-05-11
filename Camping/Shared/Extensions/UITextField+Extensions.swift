//
//  UITextField+Extensions.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

extension UITextField {
    
    func leftInset(size: CGFloat) {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size, height: self.frame.size.height))
        view.backgroundColor = .clear
        self.leftView = view
        self.leftViewMode = .always
    }
}
