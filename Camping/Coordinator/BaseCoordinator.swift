//
//  BaseCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

class BaseCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var isCompleted: (() -> Void)?
    
    func start() {
        fatalError("Children should implement 'start'")
    }
}
