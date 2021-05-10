//
//  Coordinator.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//
import UIKit

protocol Coordinator: class {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}


extension Coordinator {
    
    func add(coordinator: Coordinator) {
        self.childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0 !== coordinator })
    }
}
