//
//  OnboardingCellViewModel.swift
//  Camping
//
//  Created by Stable 09 on 11.05.2021.
//

import UIKit

protocol OnboardingCellViewPresentable {
    var image: UIImage { get }
    var title: String { get }
    var description: String { get }
}

struct OnboardingCellViewModel: OnboardingCellViewPresentable {
    var image: UIImage
    var title: String
    var description: String
}
