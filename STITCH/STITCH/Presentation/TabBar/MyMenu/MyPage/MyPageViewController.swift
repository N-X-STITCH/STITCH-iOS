//
//  MyPageViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

final class MyPageViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding6 = 6
        static let padding8 = 8
        static let padding12 = 12
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
        static let imageWidth = 108
        static let nicknameLabelHeight = 28
        static let sportsBadgeViewHeight = 20
        static let editIconWidth = 18
        static let lineHeight = 8
        
    }
    
    private let settingButton = UIButton().then {
        $0.setImage(.setting, for: .normal)
    }
    
    private let profileImageView = DefaultProfileImageView()
    
    private let nicknameLabel = UILabel().then {
        $0.text = "닉네임"
        $0.font = .Headline_20
        $0.textColor = .gray02
    }
    
    private let editButton = UIButton().then {
        $0.setImage(.edit, for: .normal)
    }
    
    private lazy var nicknameStackView = UIStackView(arrangedSubviews: [
        nicknameLabel, editButton
    ]).then {
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = CGFloat(Constant.padding6)
    }
    
    private lazy var sportsBadgeView = UIView()
    
    private let introduceLabel = UILabel().then {
        $0.text = "안녕하세요 함께 스포츠를 즐겨보아요~😀"
        $0.textAlignment = .center
        $0.font = .Body2_14
        $0.textColor = .gray06
    }
    
    private lazy var createdMatchCollectionView = MatchCollectionView(
        self,
        layout: MatchCollectionViewLayout.layout(matchSection: .createdMatchList(nickname: "")),
        matchSection: .createdMatchList(nickname: "")
    )
    
    // MARK: Properties
    
    private let myPageViewModel: MyPageViewModel
    
    // MARK: - Initializer
    
    init(myPageViewModel: MyPageViewModel) {
        self.myPageViewModel = myPageViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        let section = MatchSection.createdMatchList(nickname: "비니킴")
        createdMatchCollectionView.setData(section: section, matchInfos: [])
    }
    
    override func bind() {
        settingButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.setting)
            }
            .disposed(by: disposeBag)
        
        editButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
        
        let input = MyPageViewModel.Input(viewWillAppear: rx.viewWillAppear.asObservable())
        
        let output = myPageViewModel.transform(input: input)
        
        output.userObservable
            .asDriver(onErrorJustReturn: User())
            .drive { [weak self] user in
                guard let self else { return }
                self.configure(user: user)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        let rightBarButton = UIBarButtonItem(customView: settingButton)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func configureUI() {
        view.addSubview(profileImageView)
        view.addSubview(nicknameStackView)
        view.addSubview(sportsBadgeView)
        view.addSubview(introduceLabel)
        view.addSubview(createdMatchCollectionView)
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.imageWidth)
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding32)
            make.centerX.equalToSuperview()
        }
        
        nicknameStackView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(Constant.padding8)
            make.height.equalTo(Constant.nicknameLabelHeight)
            make.centerX.equalToSuperview()
        }
        
        sportsBadgeView.snp.makeConstraints { make in
            make.top.equalTo(nicknameStackView.snp.bottom).offset(Constant.padding12)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constant.sportsBadgeViewHeight)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(sportsBadgeView.snp.bottom).offset(Constant.padding16)
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        createdMatchCollectionView.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func configure(user: User) {
        nicknameLabel.text = user.nickname
        introduceLabel.text = user.introduce
        if let profileURLString = user.profileImageURL,
           let profileURL = URL(string: profileURLString) {
            profileImageView.kf.setImage(with: profileURL)
        }
        setBadgeView(sports: user.interestedSports)
        createdMatchCollectionView.setHeader(nickname: user.nickname)
    }
    
    private func setBadgeView(sports: [Sport]) {
        let sportBadges: [UILabel] = sports.map { SportBadge(sport: $0) }
        let stackView = UIStackView(arrangedSubviews: sportBadges).then {
            $0.axis = .horizontal
            $0.spacing = CGFloat(Constant.padding6)
        }
        if let subView = sportsBadgeView.subviews.last {
            subView.removeFromSuperview()
        }
        sportsBadgeView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDeleagte

extension MyPageViewController: UICollectionViewDelegate {}
