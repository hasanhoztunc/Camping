//
//  UICollectionView+Extensions.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

extension UICollectionView {
    
    func register(with reuseIdentifier: String) {
        self.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
}
