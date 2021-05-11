//
//  CreateNewPasswordViewCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

import RxSwift
import RxCocoa

final class CreateNewPasswordCoordinator: BaseCoordinator {
    
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(router: Routing) {
        self.router = router
    }
    
    override func start() {
        let createNewPasswordViewController = CreateNewPasswordViewController.instantiate(from: .CreateNewPassword)
        
        createNewPasswordViewController.viewModelBuilder = { [bag] in
            let viewModel = CreateNewPasswordViewModel(input: $0)
            
            viewModel
                .segue
                .newPasswordCreated
                .map({ [weak self] in
                    guard let self = self else { return }
                    self.routeToNewPasswordCreated()
                })
                .drive()
                .disposed(by: bag)
            
            return viewModel
        }
        
        router.push(createNewPasswordViewController, isAnimated: true, onNavigationBack: isCompleted)
    }
}

private extension CreateNewPasswordCoordinator {
    
    func routeToNewPasswordCreated() {
        let newPasswordCreatedViewCoordinator = NewPasswordCreatedViewCoordinator(router: self.router)
        
        self.add(coordinator: newPasswordCreatedViewCoordinator)
        
        newPasswordCreatedViewCoordinator.isCompleted = { [weak self, weak newPasswordCreatedViewCoordinator] in
            guard let self = self,
                  let coordinator = newPasswordCreatedViewCoordinator else { return }
            self.remove(coordinator: coordinator)
        }
        
        newPasswordCreatedViewCoordinator.start()
    }
}
