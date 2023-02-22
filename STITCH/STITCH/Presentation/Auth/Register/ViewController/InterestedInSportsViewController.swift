//
//  InterestedInSportsViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import RxSwift

final class InterestedInSportsViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let buttonHeight = 48
        static let padding16 = 16
        static let padding24 = 24
        static let padding40 = 40
    }
    
    // progressBar
    
    private let titleLabel = DefaultTitleLabel(text: "관심있는 운동 종목을\n3개 이상 선택하세요")
    
    private let nextButton = DefaultButton(title: "다음")
    
    private lazy var sportsCollectionView = SportsCollectionView(self)
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func setting() {
        sportsCollectionView.setData(Sport.allCases)
    }
    
    override func bind() {
        nextButton.rx.tap
            .subscribe { [weak self] _ in
                self?.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(sportsCollectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(Constant.padding24)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        sportsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding40)
            make.centerX.equalToSuperview()
            make.width.equalTo(312)
            make.bottom.equalTo(nextButton.snp.top)
        }
    }
}

// MARK: - UICollectionViewDelegate

extension InterestedInSportsViewController: UICollectionViewDelegate {
    
}
