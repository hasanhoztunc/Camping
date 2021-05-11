//
//  CreateNewPasswordViewController.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

import RxSwift
import RxCocoa

final class CreateNewPasswordViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var setPasswordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    
    private var viewModel: CreateNewPasswordViewPresentable!
    var viewModelBuilder: CreateNewPasswordViewPresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            send: sendButton.rx.tap.asDriver(), ()
        ))
        
        setupUI()
        setupBindings()
    }
}

private extension CreateNewPasswordViewController {
    
    func setupUI() {
        passwordTextField.cornerRadius = 12
        passwordTextField.border(color: .borderGray, width: 1)
        passwordTextField.leftInset(size: 16)
        
        sendButton.cornerRadius = 12
        sendButton.shadow(color: .lightGreen, size: CGSize(width: 0, height: 5))
    }
    
    func setupBindings() {
        viewModel
            .output
            .title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
    }
}
