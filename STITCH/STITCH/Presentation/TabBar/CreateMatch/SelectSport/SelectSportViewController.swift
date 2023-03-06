//
//  SelectSportViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

import RxSwift

final class SelectSportViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let collectionViewHeight = 312
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
    }
    
    private let titleLabel = DefaultTitleLabel(text: "()매치를 위한\n운동종목을 선택해주세요")
    
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
    }
    
    override func bind() {
        
        sportsCollectionView.setData(Sport.allCases)
        
        let selected = sportsCollectionView.rx.itemSelected.share()
        
        selected
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
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
        
        let input = InterestedSportsViewModel.Input(
            configureCollectionView: Single<Void>.just(()).asObservable(),
            sportSelected: selected,
            sportDeselected: deseleted
        )
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(sportsCollectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        sportsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding32)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constant.collectionViewHeight)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom)
        }

    }
}

// MARK: - UICollectionViewDelegate

extension SelectSportViewController: UICollectionViewDelegate {
    
}
