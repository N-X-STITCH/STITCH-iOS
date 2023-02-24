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
    
    private lazy var sportsCollectionView = SportsCollectionView(
        self,
        layout: SportsCollectionViewLayout.layout()
    )
    
    // MARK: Properties
    
    private let interestedInSportsViewModel: InterestedSportsViewModel
    
    // MARK: - Initializer
    
    init(interestedInSportsViewModel: InterestedSportsViewModel) {
        self.interestedInSportsViewModel = interestedInSportsViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    func setNextButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.setButtonBackgroundColor(isEnabled)
    }
    
    override func setting() {
        setNextButton(isEnabled: false)
    }
    
    override func bind() {
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe { owner,  _ in
                owner.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
        
        let selected = sportsCollectionView.rx.itemSelected.share()
        
        selected
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
                owner.sportsCollectionView.update(indexPath)
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
        
        let output = interestedInSportsViewModel.transform(input: input)
        
        output.configureCollectionViewData
            .withUnretained(self)
            .subscribe { owner, sports in
                owner.sportsCollectionView.setData(sports)
            }
            .disposed(by: disposeBag)
        
        output.selectedIndexPath
            .map { $0.count }
            .withUnretained(self)
            .subscribe { owner, count in
                if 3 <= count {
                    owner.setNextButton(isEnabled: true)
                } else {
                    owner.setNextButton(isEnabled: false)
                }
            }
            .disposed(by: disposeBag)
            
        
        output.selectDisposable.disposed(by: disposeBag)
        output.deselectDisposable.disposed(by: disposeBag)
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
