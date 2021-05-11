//
//  LoginViewModel.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import RxCocoa
import RxSwift

protocol LoginViewPresentable {
    
    typealias Input = (
        forgotPassword: Driver<Void>, ()
    )
    typealias Output = ()
    typealias ViewModelBuilder = (Input) -> LoginViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class LoginViewModel: LoginViewPresentable {
    
    let input: Input
    let output: Output

    private let bag = DisposeBag()
    
    private typealias SegueAction = (forgotPasswordRelay: PublishRelay<Void>, ())
    private let segueAction: SegueAction = (forgotPasswordRelay: PublishRelay(), ())
    
    typealias Segue = (forgotPassword: Driver<Void>, ())
    lazy var segue: Segue = (forgotPassword: segueAction.forgotPasswordRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: LoginViewPresentable.Input) {
        self.input = input
        self.output = LoginViewModel.output()
        
        process()
    }
}

private extension LoginViewModel {
    
    static func output() -> LoginViewPresentable.Output {
        return ()
    }
    
    func process() {
        input
            .forgotPassword
            .map({ [segueAction] in
                segueAction.forgotPasswordRelay.accept($0)
            })
            .drive()
            .disposed(by: bag)
    }
}
