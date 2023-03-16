//
//  MatchCategoryViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import UIKit

import RxSwift
import RxCocoa

final class MatchCategoryViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding2 = 2
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding36 = 36
        static let radius14 = 14
        static let floatingButtonWidth = 56
        static let sportCollectionViewHeight = 74
        static let barHeight = 1
        static let matchButtonWidth = 50
        static let classMatchButtonWidth = 88
        static let buttonHeight = 28
        static let peopleCountLabelHeight = 20
    }
    
    private lazy var sportCategoryCollectionView = SportCategoryCollectionView(
        self,
        layout: SportCategoryCollectionViewLayout.layout()
    )
    
    private let divisionView = UIView().then { $0.backgroundColor = .gray11 }
    
    private let matchButton = UIButton().then {
        $0.setTitle("매치", for: .normal)
        $0.titleLabel?.font = .Body2_14
        $0.setTitleColor(.gray12, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.backgroundColor = .yellow05_primary
        $0.layer.cornerRadius = CGFloat(Constant.radius14)
    }
    
    private let classMatchButton = UIButton().then {
        $0.setTitle("Teach 매치", for: .normal)
        $0.titleLabel?.font = .Body2_14
        $0.setTitleColor(.gray12, for: .selected)
        $0.setTitleColor(.white, for: .focused)
        $0.backgroundColor = .yellow05_primary
        $0.layer.cornerRadius = CGFloat(Constant.radius14)
    }
    
    private let matchCountLabel = UILabel().then {
        $0.text = "0개"
        $0.font = .Body2_14
        $0.textColor = .gray02
    }
    
    private lazy var matchCollectionView = MatchCollectionView(
        self,
        layout: MatchCollectionViewLayout.layout(matchSection: .none),
        matchSection: .none
    )
    
    private let locationButton = IconButton(iconButtonType: .location)
    
    private lazy var locationBarButton = UIBarButtonItem(customView: locationButton)
    
    private let floatingButton = FloatingButton(frame: .zero)
    
    // MARK: Properties
    
    private let matchCategoryViewModel: MatchCategoryViewModel
    
    // MARK: - Initializer
    
    init(matchCategoryViewModel: MatchCategoryViewModel) {
        self.matchCategoryViewModel = matchCategoryViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        classMatchButton.isSelected = false
        classMatchButton.setButtonBackgroundColor(false)
    }
    
    override func bind() {
        sportCategoryCollectionView.setData(Sport.allCases)
        matchCollectionView.setData(section: .none, matchInfos: [])
        
        floatingButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.generateImpactHaptic()
                owner.coordinatorPublisher.onNext(.selectMatchType)
            }
            .disposed(by: disposeBag)
        
        let selected = sportCategoryCollectionView.rx.itemSelected.share()
        
        selected
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
                owner.sportCategoryCollectionView.update(indexPath)
                // TODO: 변경
            }
            .disposed(by: disposeBag)
        
        let deseleted = sportCategoryCollectionView.rx.itemDeselected.share()
        
        deseleted
            .withUnretained(self)
            .observe(on: MainScheduler.instance)
            .subscribe { owner, indexPath in
                owner.sportCategoryCollectionView.update(indexPath)
            }
            .disposed(by: disposeBag)
        
        let input = InterestedSportsViewModel.Input(
            configureCollectionView: Single<Void>.just(()).asObservable(),
            sportSelected: selected,
            sportDeselected: deseleted
        )
    }
    
    override func configureNavigation() {
        navigationItem.leftBarButtonItem = locationBarButton
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(sportCategoryCollectionView)
        view.addSubview(divisionView)
        view.addSubviews([matchButton, classMatchButton, matchCountLabel])
        view.addSubview(matchCollectionView)
        view.addSubview(floatingButton)
        
        sportCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding2)
            make.height.equalTo(Constant.sportCollectionViewHeight)
        }
        
        divisionView.snp.makeConstraints { make in
            make.top.equalTo(sportCategoryCollectionView.snp.bottom).offset(Constant.padding12)
            make.left.right.equalToSuperview()
            make.height.equalTo(Constant.barHeight)
        }
        
        matchButton.snp.makeConstraints { make in
            make.top.equalTo(divisionView.snp.bottom).offset(Constant.padding32)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.width.equalTo(Constant.matchButtonWidth)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        classMatchButton.snp.makeConstraints { make in
            make.top.equalTo(divisionView.snp.bottom).offset(Constant.padding32)
            make.left.equalTo(matchButton.snp.right).offset(Constant.padding16)
            make.width.equalTo(Constant.classMatchButtonWidth)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        matchCountLabel.snp.makeConstraints { make in
            make.top.equalTo(divisionView.snp.bottom).offset(Constant.padding36)
            make.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.peopleCountLabelHeight)
        }
        
        matchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(matchButton.snp.bottom).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalToSuperview()
        }
        
        floatingButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalToSuperview().inset(Constant.padding24)
            make.width.height.equalTo(Constant.floatingButtonWidth)
        }
    }
}

extension MatchCategoryViewController: UICollectionViewDelegate {}
