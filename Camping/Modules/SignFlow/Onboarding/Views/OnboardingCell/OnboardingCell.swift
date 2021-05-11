//
//  OnboardingCell.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(usingViewModel viewModel: OnboardingCellViewPresentable) {
        self.imageView.image = viewModel.image
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
    }
}
