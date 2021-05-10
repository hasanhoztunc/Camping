//
//  OnboardingViewController.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit
import PageControls

final class OnboardingViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var pageControl: ScrollingPageControl!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private var viewModel: OnboardingViewPresentable!
    var viewModelBuilder: OnboardingViewPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = viewModelBuilder(())
        
        setupUI()
    }
}

private extension OnboardingViewController {
    
    func setupUI() {
        leftButton.cornerRadius = 10
        rightButton.cornerRadius = 10
        loginButton.cornerRadius = 12
    }
}
