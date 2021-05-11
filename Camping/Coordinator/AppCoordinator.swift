//
//  AppCoordinator.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        
        let navigationBar = navigationController.navigationBar
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.SFPo(weight: .Bold, size: 20),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationBar.isTranslucent = false
        
        let backImage = UIImage(named: "ic-chevron-left")!

        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
        
        navigationBar.backItem?.title = nil
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let router = Router(navigationController: navigationController)
        
        let onboardingCoordinator = OnboardingCoordinator(router: router)
        self.add(coordinator: onboardingCoordinator)
        
        onboardingCoordinator.isCompleted = { [weak self, weak onboardingCoordinator] in
            guard let coordinator = onboardingCoordinator,
                  let self = self else { return }
            self.remove(coordinator: coordinator)
        }
        
        onboardingCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
