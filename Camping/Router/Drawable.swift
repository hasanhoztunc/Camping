//
//  Drawable.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

protocol Drawable {
    
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    
    var viewController: UIViewController? {
        self
    }
}
