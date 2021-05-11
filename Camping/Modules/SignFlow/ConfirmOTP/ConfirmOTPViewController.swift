//
//  ConfirmOTPViewController.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

import RxSwift
import RxCocoa

final class ConfirmOTPViewController: UIViewController, Storyboardable {

    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var otfTextField: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    
    private var viewModel: ConfirmOTPViewPresentable!
    var viewModelBuilder: ConfirmOTPViewPresentable.ViewModelBuilder!
    
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

private extension ConfirmOTPViewController {
    
    func setupUI() {
        sendButton.cornerRadius = 12
    }
    
    func setupBindings() {
        viewModel
            .output
            .title
            .drive(navigationItem.rx.title)
            .disposed(by: bag)
        
        viewModel
            .output
            .attributedDescription
            .drive(descriptionLabel.rx.attributedText)
            .disposed(by: bag)
    }
}
