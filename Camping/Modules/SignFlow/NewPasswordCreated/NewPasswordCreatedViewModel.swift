//
//  NewPasswordCreatedViewModel.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import RxSwift
import RxCocoa

protocol NewPasswordCreatedViewPresentable {
    
    typealias Input = (
        root: Driver<Void>, ()
    )
    typealias Output = ()
    typealias ViewModelBuilder = (Input) -> NewPasswordCreatedViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class NewPasswordCreatedViewModel: NewPasswordCreatedViewPresentable {
    
    let input: Input
    let output: Output
    
    private let bag = DisposeBag()
    
    private typealias SegueAction = (rootRelay: PublishRelay<Void>, ())
    private let segueAction: SegueAction = (rootRelay: PublishRelay(), ())
    
    typealias Segue = (root: Driver<Void>, ())
    lazy var segue: Segue = (root: segueAction.rootRelay.asDriver(onErrorDriveWith: .empty()), ())
    
    init(input: NewPasswordCreatedViewPresentable.Input) {
        self.input = input
        self.output = NewPasswordCreatedViewModel.output()
        
        process()
    }
}

private extension NewPasswordCreatedViewModel {
    
    static func output() -> NewPasswordCreatedViewPresentable.Output {
        return ()
    }
    
    func process() {
        input
            .root
            .map({ [segueAction] in
                segueAction.rootRelay.accept($0)
            })
            .drive()
            .disposed(by: bag)
    }
}
