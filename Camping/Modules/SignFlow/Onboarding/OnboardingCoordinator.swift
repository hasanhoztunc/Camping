//
//  OnboardingCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

final class OnboardingCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let viewController = OnboardingViewController.instantiate(from: .Onboarding)
        
        viewController.viewModelBuilder = {
            OnboardingViewModel(input: $0)
        }
        
        router.push(viewController, isAnimated: true, onNavigationBack: isCompleted)
    }
}
