//
//  LoginViewController.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

final class LoginViewController: UIViewController, Storyboardable{
    
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTitleLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var wrongPasswordLabel: UILabel!
    @IBOutlet private weak var forgotPasswordButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private var viewModel: LoginViewPresentable!
    var viewModelBuilder: LoginViewPresentable.ViewModelBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = viewModelBuilder((
            forgotPassword: forgotPasswordButton.rx.tap.asDriver(), ()
        ))
        
        setupUI()
    }
}

private extension LoginViewController {
    
    func setupUI() {
        emailTextField.cornerRadius = 12
        emailTextField.border(color: .borderGray, width: 1)
        emailTextField.leftInset(size: 16)
        
        passwordTextField.cornerRadius = 12
        passwordTextField.border(color: .borderGray, width: 1)
        passwordTextField.leftInset(size: 16)
        
        loginButton.cornerRadius = 12
        loginButton.shadow(color: .shadowGray, size: CGSize(width: 0, height: 5))
        
        registerButton.cornerRadius = 12
        registerButton.border(color: .lightGreen, width: 1)
    }
}
