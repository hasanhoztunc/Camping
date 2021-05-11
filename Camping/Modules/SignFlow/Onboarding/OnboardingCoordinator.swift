//
//  OnboardingCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

import RxSwift
import RxCocoa

final class OnboardingCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let viewController = OnboardingViewController.instantiate(from: .Onboarding)
        
        viewController.viewModelBuilder = { [bag] in
            let viewModel = OnboardingViewModel(input: $0)
            
            viewModel
                .segue
                .login
                .map({ [weak self] in
                    self?.routeToLogin()
                })
                .asDriver()
                .drive()
                .disposed(by: bag)
            
            viewModel
                .segue
                .register
                .map({ [weak self] in
                    self?.routeToRegister()
                })
                .asDriver()
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(viewController, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension OnboardingCoordinator {
    
    func routeToLogin() {
        let loginViewCoordinator = LoginViewCoordinator(router: self.router)
        
        self.add(coordinator: loginViewCoordinator)
        
        loginViewCoordinator.isCompleted = { [weak self, weak loginViewCoordinator] in
            guard let self = self,
                  let coordinator = loginViewCoordinator else{ return }
            self.remove(coordinator: coordinator)
        }
        
        loginViewCoordinator.start()
    }
    
    func routeToRegister() {
        let registerViewCoordinator = RegisterViewCoordinator(router: self.router)
        
        self.add(coordinator: registerViewCoordinator)
        
        registerViewCoordinator.isCompleted = { [weak self, weak registerViewCoordinator] in
            guard let self = self,
                  let coordinator = registerViewCoordinator else { return }
            self.remove(coordinator: coordinator)
        }
        
        registerViewCoordinator.start()
    }
}
