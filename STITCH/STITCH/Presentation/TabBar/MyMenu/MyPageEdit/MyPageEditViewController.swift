//
//  MyPageEditViewController.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

final class MyPageEditViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding2 = 2
        static let padding6 = 6
        static let padding12 = 12
        static let padding16 = 16
        static let padding20 = 20
        static let padding24 = 24
        static let padding32 = 32
        static let padding40 = 40
        static let contentHeight = 1000
        static let titleHeight = 20
        static let textFieldHeight = 55
        static let countLabelHeight = 18
        static let barHeight = 1
        static let divisionHeight = 8
        static let navigationButtonWidth = 48
        static let imageWidth = 108
        static let cameraButtonWidth = 36
        static let collectionViewWidth = 312
        static let collectionViewHeight = 416
    }
    
    private let xButton = UIButton().then {
        $0.setImage(.xmark, for: .normal)
        $0.tintColor = .gray02
    }
    
    private let navigationTitleLabel = UILabel().then {
        $0.text = "프로필 수정"
        $0.textColor = .gray02
        $0.font = .Subhead_16
    }
    
    private let finishButton = UIButton().then {
        $0.titleLabel?.font = .Body1_16
        $0.setTitleColor(.gray10, for: .disabled)
        $0.setTitleColor(.gray02, for: .normal)
        $0.setTitle("완료", for: .normal)
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let profileImageView = DefaultProfileImageView()

    private lazy var cameraButton = UIButton().then {
        $0.setImage(.cameraIcon, for: .normal)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
    }
    
    private let nicknameLabel = DefaultTitleLabel(text: "이름", textColor: .gray02, font: .Subhead2_14)
    private let nicknameTextField = DefaultTextField(placeholder: "이름 validation")
    private let nicknameRowView = UIView().then { $0.backgroundColor  = .gray09 }
    private let nicknameCountLabel = DefaultTitleLabel(text: "0 / 20", textColor: .gray09, font: .Caption1_12)
    
    private let introduceLabel = DefaultTitleLabel(text: "자기소개", textColor: .gray02, font: .Subhead2_14)
    private let introduceTextField = DefaultTextField(placeholder: "자기소개 validation")
    private let introduceRowView = UIView().then { $0.backgroundColor  = .gray09 }
    private let introduceCountLabel = DefaultTitleLabel(text: "0 / 300", textColor: .gray09, font: .Caption1_12)
    
    private let divisionView = UIView().then {
        $0.backgroundColor = .gray12
    }
    
    private let sportTitleLabel = DefaultTitleLabel(
        text: "관심있는 운동종목",
        textColor: .gray02,
        font: .Subhead2_14
    )
    
    private lazy var sportsCollectionView = SportsCollectionView(
        self,
        layout: SportsCollectionViewLayout.layout(),
        allowsMultipleSelection: true
    )
    
    // MARK: Properties
    
    private let myPageEditViewModel: MyPageEditViewModel
    private lazy var imagePickerController = ImagePickerController()
    
    // MARK: - Initializer
    
    init(myPageEditViewModel: MyPageEditViewModel) {
        self.myPageEditViewModel = myPageEditViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        imagePickerController.delegate = self
        sportsCollectionView.setData(Array(Sport.allCases[1...]))
    }
    
    override func bind() {
        let imageObservable = cameraButton.rx.tap
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.imagePickerController.pickImage(allowsEditing: true)
            }
            .share()
        
        imageObservable
            .bind(to: profileImageView.rx.image)
            .disposed(by: disposeBag)

        xButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.dismiss)
            }
            .disposed(by: disposeBag)
        
        let selected = sportsCollectionView.rx.itemSelected.share()
        
        selected
            .withUnretained(self)
            .subscribe { owner, indexPath in
                owner.sportsCollectionView.update(indexPath)
            }
            .disposed(by: disposeBag)
        
        let deseleted = sportsCollectionView.rx.itemDeselected.share()
        
        deseleted
            .withUnretained(self)
            .subscribe { owner, indexPath in
                owner.sportsCollectionView.update(indexPath)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(xButton)
        view.addSubview(navigationTitleLabel)
        view.addSubview(finishButton)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(cameraButton)
        contentView.addSubviews([nicknameLabel, nicknameTextField, nicknameRowView, nicknameCountLabel])
        contentView.addSubviews([introduceLabel, introduceTextField, introduceRowView, introduceCountLabel])
        contentView.addSubviews([divisionView, sportTitleLabel, sportsCollectionView])
        
        xButton.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.navigationButtonWidth)
            make.top.left.equalTo(view.safeAreaLayoutGuide)
        }
        
        navigationTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(xButton)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        finishButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constant.padding6)
            make.right.equalTo(view.safeAreaLayoutGuide).inset(Constant.padding12)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(xButton.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.contentLayoutGuide.snp.makeConstraints { make in
            make.height.equalTo(Constant.contentHeight)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height).priority(.low)
        }
        
        configureProfileView()
        configureNicknameView()
        configureIntroduceLabel()
        configureSportsCollectionView()
    }
}

// MARK: - UICollectionViewDelegate

extension MyPageEditViewController: UICollectionViewDelegate {
}

// MARK: - UI

extension MyPageEditViewController {
    private func configureProfileView() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Constant.imageWidth)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.right.equalTo(profileImageView.snp.right)
            make.bottom.equalTo(profileImageView.snp.bottom)
            make.width.height.equalTo(Constant.cameraButtonWidth)
        }
    }
    
    private func configureNicknameView() {
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(Constant.padding20)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        nicknameRowView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
        
        nicknameCountLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameRowView.snp.bottom).offset(Constant.padding2)
            make.right.equalToSuperview().inset(Constant.padding24)
            make.height.equalTo(Constant.countLabelHeight)
        }
    }
    
    private func configureIntroduceLabel() {
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameCountLabel.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        introduceTextField.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        introduceRowView.snp.makeConstraints { make in
            make.top.equalTo(introduceTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
        
        introduceCountLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceRowView.snp.bottom).offset(Constant.padding2)
            make.right.equalToSuperview().inset(Constant.padding24)
            make.height.equalTo(Constant.countLabelHeight)
        }
    }
    
    func configureSportsCollectionView() {
        divisionView.snp.makeConstraints { make in
            make.top.equalTo(introduceCountLabel.snp.bottom).offset(Constant.padding40)
            make.left.right.equalToSuperview()
            make.height.equalTo(Constant.divisionHeight)
        }
        
        sportTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(divisionView.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.titleHeight)
        }
        
        sportsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(sportTitleLabel.snp.bottom).offset(Constant.padding24)
            make.centerX.equalToSuperview()
            make.width.equalTo(Constant.collectionViewWidth)
            make.height.equalTo(Constant.collectionViewHeight)
        }
    }
}
