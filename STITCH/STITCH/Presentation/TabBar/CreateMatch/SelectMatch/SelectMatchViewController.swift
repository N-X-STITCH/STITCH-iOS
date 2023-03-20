//
//  SelectMatchViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import UIKit

import RxSwift
import RxCocoa

final class SelectMatchViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let buttonHeight = 48
        static let collectionViewHeight = 172
    }
    
    private let titleLabel = DefaultTitleLabel(text: "원하시는 매치를 선택해주세요")
    
    private lazy var matchTypeCollectionView = MatchTypeCollectionView(
        self,
        layout: MatchTypeCollectionViewLayout.layout()
    )
    
    private let nextButton = DefaultButton(title: "다음")
    
    // MARK: Properties
    
    private let createMatchViewModel: CreateMatchViewModel
    
    // MARK: - Initializer
    
    init(createMatchViewModel: CreateMatchViewModel) {
        self.createMatchViewModel = createMatchViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    private func setNextButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.setButtonBackgroundColor(isEnabled)
    }
    
    override func setting() {
        setNextButton(isEnabled: false)
    }
    
    override func bind() {
        // TODO: 삭제
        matchTypeCollectionView.setData(CreateMatchType.allCases)
        
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
        
        let selected = matchTypeCollectionView.rx.itemSelected.share()
        
        selected
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
                if indexPath.row == 0 {
                    owner.createMatchViewModel.newMatch.matchType = .match
                } else {
                    owner.createMatchViewModel.newMatch.matchType = .teachMatch
                }
                owner.matchTypeCollectionView.update(indexPath)
                owner.setNextButton(isEnabled: true)
            }
            .disposed(by: disposeBag)
        
        let deseleted = matchTypeCollectionView.rx.itemDeselected.share()
        
        deseleted
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
                owner.matchTypeCollectionView.update(indexPath)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(matchTypeCollectionView)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.right.equalToSuperview().offset(Constant.padding16)
        }
        
        matchTypeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(nextButton.snp.top)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(Constant.padding24)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
}

extension SelectMatchViewController: UICollectionViewDelegate {
    
}
