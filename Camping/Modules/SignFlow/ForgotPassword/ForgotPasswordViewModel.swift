//
//  ForgotPasswordViewModel.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import RxSwift
import RxCocoa

protocol ForgotPasswordViewPresentable {
    
    typealias Input = (
        send: Driver<Void>, ()
    )
    typealias Output = (
        title: Driver<String>, ()
    )
    typealias ViewModelBuilder = (Input) -> ForgotPasswordViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class ForgotPasswordViewModel: ForgotPasswordViewPresentable {
    
    let input: Input
    let output: Output
    
    private let bag = DisposeBag()
    
    private typealias SegueAction = (confirmOTPRelay: PublishRelay<Void>, ())
    private let segueAction: SegueAction = (confirmOTPRelay: PublishRelay(), ())
    
    typealias Segue = (confirmOTP: Driver<Void>, ())
    lazy var segue: Segue = (confirmOTP: segueAction.confirmOTPRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: ForgotPasswordViewPresentable.Input) {
        self.input = input
        self.output = ForgotPasswordViewModel.output()
        
        process()
    }
}

private extension ForgotPasswordViewModel {
    
    static func output() -> ForgotPasswordViewPresentable.Output {
        return (
            title: Driver.just("Forgot Password"), ()
        )
    }
    
    func process() {
        input
            .send
            .map({ [segueAction] in
                segueAction.confirmOTPRelay.accept($0)
            })
            .drive()
            .disposed(by: bag)
    }
}
