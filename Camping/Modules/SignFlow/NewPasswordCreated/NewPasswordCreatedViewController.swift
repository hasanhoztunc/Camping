//
//  NewPasswordCreatedViewController.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

final class NewPasswordCreatedViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var goBackButton: UIButton!

    private var viewModel: NewPasswordCreatedViewPresentable!
    var viewModelBuilder: NewPasswordCreatedViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            root: goBackButton.rx.tap.asDriver(), ()
        ))
        
        setupUI()
    }
}

private extension NewPasswordCreatedViewController {
    
    func setupUI() {
        goBackButton.cornerRadius = 12
        goBackButton.shadow(color: .shadowGray, size: CGSize(width: 0, height: 5))
    }
}
