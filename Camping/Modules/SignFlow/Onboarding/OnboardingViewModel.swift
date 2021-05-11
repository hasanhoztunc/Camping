//
//  OnboardingViewModel.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias OnboardingCells = SectionModel<Int, OnboardingCellViewPresentable>

protocol OnboardingViewPresentable {
    
    typealias Input = (
        login: Driver<Void>,
        register: Driver<Void>
    )
    typealias Output = (
        onboardingCells: Driver<[OnboardingCells]>,
        registerButtonTitle: Driver<NSAttributedString>
    )
    typealias ViewModelBuilder = (Input) -> OnboardingViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class OnboardingViewModel: OnboardingViewPresentable {
    
    let input: Input
    let output: Output
    
    private let bag = DisposeBag()
    
    private typealias SegueAction = (loginRelay: PublishRelay<Void>, registerRelay: PublishRelay<Void>)
    private let segueAction: SegueAction = (loginRelay: PublishRelay(), registerRelay: PublishRelay())
    
    typealias Segue = (login: Driver<Void>, register: Driver<Void>)
    lazy var segue: Segue = (
        login: segueAction.loginRelay.asDriver(onErrorDriveWith: .empty()),
        register: segueAction.registerRelay.asDriver(onErrorDriveWith: .empty())
    )
    
    init(input: OnboardingViewPresentable.Input) {
        self.input = input
        self.output = OnboardingViewModel.output()
        
        process()
    }
}

private extension OnboardingViewModel {
    
    static func output() -> OnboardingViewPresentable.Output {
        let cells = Observable
            .of([
                OnboardingCellViewModel(image: AppImages.OnboardingMuchMore!, title: "Your Tasks", description: "I always reminds you about your planned activities. which is always my priority and your importance."),
                OnboardingCellViewModel(image: AppImages.OnboardingCapture!, title: "Capture Your Memories", description: "We know that catching photos are necessary in your trip. that’s why we have built-in camera and gallery feature."),
                OnboardingCellViewModel(image: AppImages.OnboardingTrack!, title: "Track Your Fitness", description: "Fitness is one of the main thing which is really inportant to your body and we track it in every second."),
                OnboardingCellViewModel(image: AppImages.OnboardingMuchMore!, title: "There Is Much More", description: "We have bunch of other cool features. which is super helpful for your next camping trip. so what are you waiting for?")
            ])
            .map({
                [OnboardingCells(model: 0, items: $0)]
            })
            .asDriver(onErrorJustReturn: [])
        let boldFont = UIFont.SFPo(weight: .Medium, size: 16)
        let regularFont = UIFont.SFPo(weight: .Regular, size: 16)
        let registerButtonTitle = LocalizedString("Don’t have an Account? Register").attributedString(withFonts: (default: regularFont, bold: boldFont))
        
        return (
            onboardingCells: cells,
            registerButtonTitle: Driver.just(registerButtonTitle)
        )
    }
    
    func process() {
        input
            .login
            .map({ [segueAction] in
                segueAction.loginRelay.accept($0)
            })
            .asDriver()
            .drive()
            .disposed(by: bag)
        
        input
            .register
            .map({ [segueAction] in
                segueAction.registerRelay.accept($0)
            })
            .asDriver()
            .drive()
            .disposed(by: bag)
    }
}
