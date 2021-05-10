//
//  Storyboardable.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

protocol Storyboardable {
    static func instantiate(from storyboard: Storyboards) -> Self
}

extension Storyboardable where Self: UIViewController {
    
    static func instantiate(from storyboard: Storyboards) -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        
        return storyboard.instantiateViewController(identifier: className)
    }
}
