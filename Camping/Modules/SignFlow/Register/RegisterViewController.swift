//
//  RegisterViewController.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

final class RegisterViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var wrongEmailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var phoneTextField: UITextField!
    @IBOutlet private weak var passwordLabel: UILabel!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!

    private var viewModel: RegisterViewPresentable!
    var viewModelBuilder: RegisterViewPresentable.ViewModelBuilder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = viewModelBuilder(())
        
        setupUI()
    }
}

private extension RegisterViewController {
    
    func setupUI() {
        nameTextField.cornerRadius = 12
        nameTextField.border(color: .borderGray, width: 1)
        nameTextField.leftInset(size: 16)
        
        emailTextField.cornerRadius = 12
        emailTextField.border(color: .borderGray, width: 1)
        emailTextField.leftInset(size: 16)
        
        phoneTextField.cornerRadius = 12
        phoneTextField.border(color: .borderGray, width: 1)
        phoneTextField.leftInset(size: 16)
        
        passwordTextField.cornerRadius = 12
        passwordTextField.border(color: .borderGray, width: 1)
        passwordTextField.leftInset(size: 16)
        
        registerButton.cornerRadius = 12
        registerButton.shadow(color: .shadowGray, size: CGSize(width: 0, height: 5))
        
        loginButton.cornerRadius = 12
        loginButton.border(color: .lightGreen, width: 1)
    }
}
