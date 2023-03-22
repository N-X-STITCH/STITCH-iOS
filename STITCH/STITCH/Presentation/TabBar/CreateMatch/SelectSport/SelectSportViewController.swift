//
//  SelectSportViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

import RxSwift

final class SelectSportViewController: BaseViewController, BackButtonProtocol {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let collectionViewWidth = 336
    }
    
    var backButton: UIButton!
    
    private let gradationView = UIImageView(image: .yellowGradation)
    
    private let titleLabel = DefaultTitleLabel(text: "매치를 위한\n운동종목을 선택해주세요")
    
    private lazy var sportsCollectionView = SportsCollectionView(
        self,
        layout: SportsCollectionViewLayout.layout(),
        allowsMultipleSelection: false
    )
    
    // MARK: Properties
    
    private let createMatchViewModel: CreateMatchViewModel
    
    // MARK: - Initializer
    
    init(
        createMatchViewModel: CreateMatchViewModel
    ) {
        self.createMatchViewModel = createMatchViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        addBackButtonTap()
    }
    
    override func bind() {
        
        sportsCollectionView.setData(Array(Sport.allCases[1...]))
        
        let selected = sportsCollectionView.rx.itemSelected.share()
        
        selected
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
                owner.createMatchViewModel.newMatch.sport = Sport.allCases[indexPath.row + 1]
                owner.sportsCollectionView.update(indexPath)
                // TODO: 변경
                owner.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
        
        let deseleted = sportsCollectionView.rx.itemDeselected.share()
        
        deseleted
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
                owner.sportsCollectionView.update(indexPath)
            }
            .disposed(by: disposeBag)
        
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(gradationView)
        view.addSubview(titleLabel)
        view.addSubview(sportsCollectionView)
        
        gradationView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        sportsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding32)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constant.collectionViewWidth)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }
    }
    
    override func configureNavigation() {
        navigationItem.title = "운동종목 선택"
    }
}

// MARK: - UICollectionViewDelegate

extension SelectSportViewController: UICollectionViewDelegate {
    
}

