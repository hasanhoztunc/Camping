//
//  OnboardingViewModel.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

protocol OnboardingViewPresentable {
    
    typealias Input = ()
    typealias Output = ()
    typealias ViewModelBuilder = (Input) -> OnboardingViewPresentable
    
    var input: Input { get }
    var output: Output { get }
}

final class OnboardingViewModel: OnboardingViewPresentable {
    
    let input: Input
    let output: Output
    
    init(input: OnboardingViewPresentable.Input) {
        self.input = input
        self.output = OnboardingViewModel.output()
    }
}

private extension OnboardingViewModel {
    
    static func output() -> OnboardingViewPresentable.Output {
        return ()
    }
}
