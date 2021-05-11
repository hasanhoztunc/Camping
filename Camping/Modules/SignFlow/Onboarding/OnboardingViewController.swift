//
//  OnboardingViewController.swift
//  Camping
//
//  Created by Stable 09 on 10.05.2021.
//

import UIKit

import PageControls
import RxSwift
import RxCocoa
import RxDataSources

final class OnboardingViewController: UIViewController, Storyboardable {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var leftButton: UIButton!
    @IBOutlet private weak var pageControl: ScrollingPageControl!
    @IBOutlet private weak var rightButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<OnboardingCells> { dataSource, collectionView, indexPath, item in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingViewController.CellIdentifier, for: indexPath) as! OnboardingCell
        cell.configure(usingViewModel: item)
        
        return cell
    }
    
    private static let CellIdentifier = "OnboardingCell"
    private var currentCell: IndexPath = IndexPath(row: 0, section: 0)
    
    private var viewModel: OnboardingViewPresentable!
    var viewModelBuilder: OnboardingViewPresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = viewModelBuilder((
            login: loginButton.rx.tap.asDriver(),
            register: registerButton.rx.tap.asDriver()
        ))
        
        setupUI()
        setupBindings()
    }
}

private extension OnboardingViewController {
    
    func setupUI() {
        leftButton.cornerRadius = 10
        rightButton.cornerRadius = 10
        loginButton.cornerRadius = 12
        
        collectionView.register(with: OnboardingViewController.CellIdentifier)
        
        loginButton.layer.shadowColor = UIColor.shadowGray.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 5)
        loginButton.layer.shadowRadius = 0
        loginButton.layer.shadowOpacity = 1
        loginButton.layer.masksToBounds = false
        
        leftButton.isHidden = true
    }
    
    func setupBindings() {
        viewModel
            .output
            .onboardingCells
            .drive(collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        viewModel
            .output
            .registerButtonTitle
            .drive(registerButton.rx.attributedTitle())
            .disposed(by: bag)

        rightButton
            .rx
            .tap
            .map({ [weak self] in
                guard let self = self else { return }
                let scrollTo = (self.currentCell.row < 3) ? (self.currentCell.row + 1) : 0
                scrollTo > 2 ? (self.rightButton.isHidden = true) : (self.rightButton.isHidden = false)
                scrollTo < 1 ? (self.leftButton.isHidden = true) : (self.leftButton.isHidden = false)
                self.changeCurrentPage(to: scrollTo)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
        
        leftButton
            .rx
            .tap
            .map({ [weak self] in
                guard let self = self else { return }
                let scrollTo = self.currentCell.row > 0 ? self.currentCell.row - 1 : 3
                scrollTo > 2 ? (self.rightButton.isHidden = true) : (self.rightButton.isHidden = false)
                scrollTo < 1 ? (self.leftButton.isHidden = true) : (self.leftButton.isHidden = false)
                self.changeCurrentPage(to: scrollTo)
            })
            .asDriver(onErrorDriveWith: .empty())
            .drive()
            .disposed(by: bag)
    }
    
    func changeCurrentPage(to page: Int) {
        self.currentCell = IndexPath(row: page, section: 0)
        self.collectionView.isPagingEnabled = false
        self.collectionView.scrollToItem(at: IndexPath(row: page, section: 0), at: .left, animated: true)
        self.collectionView.isPagingEnabled = true
        self.pageControl.progress = CGFloat(page)
    }
}
