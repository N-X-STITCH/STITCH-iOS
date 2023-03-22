//
//  InterestedInSportsViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import RxSwift

final class InterestedInSportsViewController: BaseViewController, BackButtonProtocol {
    
    // MARK: - Properties
    
    enum Constant {
        static let barHeight = 4
        static let buttonHeight = 48
        static let bottomGradientViewHeight = 116
        static let padding16 = 16
        static let padding24 = 24
        static let padding40 = 40
        static let collectionViewWidth = 336
    }
    
    var backButton: UIButton!
    
    private let bottomGradientView = UIImageView(image: .bottomGridientView)
    
    private let titleLabel = DefaultTitleLabel(text: "관심있는 운동 종목을\n3개 이상 선택하세요")
    
    private let nextButton = DefaultButton(title: "다음")
    
    private lazy var sportsCollectionView = SportsCollectionView(
        self,
        layout: SportsCollectionViewLayout.layout()
    )
    
    // MARK: Properties
    
    private let interestedInSportsViewModel: InterestedSportsViewModel
    private let signupViewModel: SignupViewModel
    
    // MARK: - Initializer
    
    init(
        interestedInSportsViewModel: InterestedSportsViewModel,
        signupViewModel: SignupViewModel
    ) {
        self.interestedInSportsViewModel = interestedInSportsViewModel
        self.signupViewModel = signupViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    func setNextButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.setButtonBackgroundColor(isEnabled)
    }
    
    override func setting() {
        setNextButton(isEnabled: false)
        addBackButtonTap()
    }
    
    override func bind() {
        
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
        
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe { owner,  _ in
                owner.coordinatorPublisher.onNext(.next)
                let sports = output.selectedIndexPath.value.map { Sport.allCases[$0.row + 1] }
                owner.signupViewModel.sports = sports
            }
            .disposed(by: disposeBag)
        
        output.selectDisposable.disposed(by: disposeBag)
        output.deselectDisposable.disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(sportsCollectionView)
        view.addSubview(bottomGradientView)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        sportsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding40)
            make.centerX.equalToSuperview().offset(10)
            make.width.equalTo(Constant.collectionViewWidth)
            make.bottom.equalTo(nextButton.snp.top)
        }
        
        bottomGradientView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(Constant.bottomGradientViewHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(Constant.padding24)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
    
    override func configureNavigation() {
        navigationItem.title = "회원가입"
    }
}

// MARK: - UICollectionViewDelegate

extension InterestedInSportsViewController: UICollectionViewDelegate {
    
}
