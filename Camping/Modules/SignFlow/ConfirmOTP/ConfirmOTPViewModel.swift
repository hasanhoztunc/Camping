//
//  ConfirmOTPViewModel.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//
import Foundation

import RxSwift
import RxCocoa

protocol ConfirmOTPViewPresentable {
    
    typealias Input = (
        send: Driver<Void>, ()
    )
    typealias Output = (
        attributedDescription: Driver<NSAttributedString>,
        title: Driver<String>
    )
    typealias ViewModelBuilder = (Input) -> ConfirmOTPViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class ConfirmOTPViewModel: ConfirmOTPViewPresentable {
    
    let input: Input
    let output: Output
    
    private let bag = DisposeBag()
    
    private typealias SegueAction = (createNewPasswordRelay: PublishRelay<Void>, ())
    private let segueAction: SegueAction = (createNewPasswordRelay: PublishRelay(), ())
    
    typealias Segue = (createNewPassword: Driver<Void>, ())
    lazy var segue: Segue = (createNewPassword: segueAction.createNewPasswordRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: ConfirmOTPViewPresentable.Input) {
        self.input = input
        self.output = ConfirmOTPViewModel.output()
        
        process()
    }
}

private extension ConfirmOTPViewModel {
    
    static func output() -> ConfirmOTPViewPresentable.Output {
        let description = LocalizedString("Please confirm your 4 digit OTP. which is sent on this number +1202-555-0174 Change number.")
            .attributedString(withFonts: (default: UIFont.SFPo(weight: .Regular, size: 17), bold: UIFont.SFPo(weight: .Bold, size: 17)))
        
        return (
            attributedDescription: Driver.just(description),
            title: Driver.just("Confirm OTP")
        )
    }
    
    func process() {
        input
            .send
            .map({ [segueAction] in
                segueAction.createNewPasswordRelay.accept($0)
            })
            .drive()
            .disposed(by: bag)
    }
}
