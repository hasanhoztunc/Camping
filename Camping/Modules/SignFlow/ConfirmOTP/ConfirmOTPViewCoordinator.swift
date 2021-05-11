//
//  ConfirmOTPViewCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

import RxCocoa
import RxSwift

final class ConfirmOTPViewCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let confirmOTPViewController = ConfirmOTPViewController.instantiate(from: .ConfirmOTP)
        
        confirmOTPViewController.viewModelBuilder = { [bag] in
            let viewController = ConfirmOTPViewModel(input: $0)
            
            viewController
                .segue
                .createNewPassword
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.routeToCreateNewPassword()
                })
                .drive()
                .disposed(by: bag)
            
            return viewController
        }
        
        router.push(confirmOTPViewController, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension ConfirmOTPViewCoordinator {
    
    func routeToCreateNewPassword() {
        let createNewPasswordCoordinator = CreateNewPasswordCoordinator(router: self.router)
        
        self.add(coordinator: createNewPasswordCoordinator)
        
        createNewPasswordCoordinator.isCompleted = { [weak self, weak createNewPasswordCoordinator] in
            guard let self = self,
                  let coordinator = createNewPasswordCoordinator else { return }
            self.remove(coordinator: coordinator)
        }
        
        createNewPasswordCoordinator.start()
    }
}
