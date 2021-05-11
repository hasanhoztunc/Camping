//
//  ForgotPasswordViewController.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

import RxCocoa
import RxSwift

final class ForgotPasswordViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!

    private var viewModel: ForgotPasswordViewPresentable!
    var viewModelBuilder: ForgotPasswordViewPresentable.ViewModelBuilder!
    
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

private extension ForgotPasswordViewController {
    
    func setupUI() {
        phoneTextField.cornerRadius = 12
        phoneTextField.border(color: .borderGray, width: 1)
        phoneTextField.leftInset(size: 16)
        phoneTextField.placeholder = "+1"
        
        sendButton.cornerRadius = 12
        sendButton.shadow(color: .shadowGray, size: CGSize(width: 0, height: 5))
    }
    
    func setupBindings() {
        viewModel
            .output
            .title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
    }
}
