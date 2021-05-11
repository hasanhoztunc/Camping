//
//  CreateNewPasswordViewModel.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import RxSwift
import RxCocoa

protocol CreateNewPasswordViewPresentable {
    
    typealias Input = (
        send: Driver<Void>, ()
    )
    typealias Output = (
        title: Driver<String>, ()
    )
    typealias ViewModelBuilder = (Input) -> CreateNewPasswordViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class CreateNewPasswordViewModel: CreateNewPasswordViewPresentable {
    
    let input: Input
    let output: Output

    private let bag = DisposeBag()
    
    private typealias SegueAction = (newPasswordCreatedRelay: PublishRelay<Void>, ())
    private let segueAction: SegueAction = (newPasswordCreatedRelay: PublishRelay(), ())
    
    typealias Segue = (newPasswordCreated: Driver<Void>, ())
    lazy var segue: Segue = (newPasswordCreated: segueAction.newPasswordCreatedRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: CreateNewPasswordViewPresentable.Input) {
        self.input = input
        self.output = CreateNewPasswordViewModel.output()
        
        process()
    }
}

private extension CreateNewPasswordViewModel {
    
    static func output() -> CreateNewPasswordViewPresentable.Output {
        return (
            title: Driver.just("New Password"), ()
        )
    }
    
    func process() {
        input
            .send
            .map({ [segueAction] in
                segueAction.newPasswordCreatedRelay.accept($0)
            })
            .drive()
            .disposed(by: bag)
    }
}
