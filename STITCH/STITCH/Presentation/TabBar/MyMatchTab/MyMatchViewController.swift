//
//  MyMatchViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/21.
//

import UIKit

import RxSwift
import RxCocoa

final class MyMatchViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding2 = 2
        static let padding8 = 8
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
    
    private let divisionView = UIView().then { $0.backgroundColor = .gray11 }
    
    private let matchCountLabel = UILabel().then {
        $0.text = "0개 참여중"
        $0.font = .Body2_14
        $0.textColor = .gray02
    }
    
    private let refreshControl = UIRefreshControl()
    private lazy var matchCollectionView = MatchCollectionView(
        self,
        layout: MatchCollectionViewLayout.layout(matchSection: .none),
        matchSection: .none
    ).then {
        $0.refreshControl = self.refreshControl
    }
    
    // MARK: Properties
    
    private let myMatchViewModel: MyMatchViewModel
    
    // MARK: - Initializer
    
    init(myMatchViewModel: MyMatchViewModel) {
        self.myMatchViewModel = myMatchViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
    }
    
    override func bind() {
        
        let matchSelected = matchCollectionView.rx.itemSelected.share()
        
        matchSelected
            .withUnretained(self)
            .subscribe { owner, indexPath in
                guard let matchCell = owner.matchCollectionView.cellForItem(at: indexPath) as? MatchCell else { return }
                owner.coordinatorPublisher.onNext(.created(match: matchCell.match))
            }
            .disposed(by: disposeBag)

        let refreshObservalble = refreshControl.rx.controlEvent(.valueChanged).asObservable().share()
        
        let input = MyMatchViewModel.Input(
            viewDidLoad: Observable.just(Void()),
            refreshObservalble: refreshObservalble
        )
        
        let output = myMatchViewModel.transform(input: input)
        
        let myMatchObservable = output.myMatchObservable.share()
        
        myMatchObservable
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] matchs in
                guard let owner = self else { return }
                owner.refreshControl.endRefreshing()
                owner.matchCollectionView.setData(section: .none, matchInfos: matchs.map { MatchInfo(match: $0, owner: User()) })
                owner.matchCountLabel.text = "\(matchs.count)개 참여중"
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        navigationItem.title = "마이매치 목록"
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(matchCountLabel)
        view.addSubview(matchCollectionView)
        
        matchCountLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.peopleCountLabelHeight)
        }
        
        matchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(matchCountLabel.snp.bottom).offset(Constant.padding16)
            make.left.equalToSuperview()
            make.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalToSuperview()
        }
    }
}

extension MyMatchViewController: UICollectionViewDelegate {}
