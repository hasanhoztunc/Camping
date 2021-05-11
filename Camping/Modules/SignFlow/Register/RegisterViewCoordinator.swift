//
//  RegisterViewCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

final class RegisterViewCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let registerViewController = RegisterViewController.instantiate(from: .Register)
        
        registerViewController.viewModelBuilder = {
            RegisterViewModel(input: $0)
        }
        
        router.push(registerViewController, isAnimated: true, onNavigationBack: isCompleted)
    }
}
