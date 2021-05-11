//
//  LoginViewCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let loginViewController = LoginViewController.instantiate(from: .Login)
        
        loginViewController.viewModelBuilder = { [bag] in
            let viewModel = LoginViewModel(input: $0)
            
            viewModel
                .segue
                .forgotPassword
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.routeToForgotPassword()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(loginViewController, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension LoginViewCoordinator {
    
    func routeToForgotPassword() {
        let forgotPasswordViewCoordinator = ForgotPasswordViewCoordinator(router: self.router)
        
        self.add(coordinator: forgotPasswordViewCoordinator)
        
        forgotPasswordViewCoordinator.isCompleted = { [weak self, weak forgotPasswordViewCoordinator] in
            guard let self = self,
                  let coordinator = forgotPasswordViewCoordinator else { return }
            self.remove(coordinator: coordinator)
        }
        
        forgotPasswordViewCoordinator.start()
    }
}
