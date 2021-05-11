//
//  ForgotPasswordViewCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

import RxSwift
import RxCocoa

final class ForgotPasswordViewCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let forgotPasswordViewController = ForgotPasswordViewController.instantiate(from: .ForgotPassword)
        
        forgotPasswordViewController.viewModelBuilder = { [bag] in
            let viewModel = ForgotPasswordViewModel(input: $0)
            
            viewModel.segue
                .confirmOTP
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.routeToConfirmOTP()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(forgotPasswordViewController, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension ForgotPasswordViewCoordinator {
    
    func routeToConfirmOTP() {
        let confirmOTPCoordinator = ConfirmOTPViewCoordinator(router: self.router)
        
        self.add(coordinator: confirmOTPCoordinator)
        
        confirmOTPCoordinator.isCompleted = { [weak self, weak confirmOTPCoordinator] in
            guard let self = self,
                  let coordinator = confirmOTPCoordinator else { return }
            self.remove(coordinator: coordinator)
        }
        
        confirmOTPCoordinator.start()
    }
}
