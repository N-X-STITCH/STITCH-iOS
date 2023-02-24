//
//  ProfileViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import RxSwift
import RxCocoa

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let profileWidth = 125
        static let cameraIconWidth = 48
        static let titleHeight = 56
        static let buttonHeight = 48
        static let padding10 = 10
        static let padding16 = 16
        static let padding24 = 24
        static let padding32 = 32
        static let padding48 = 48
    }
    
    // progressBar
    
    private let titleLabel = DefaultTitleLabel(text: "나의 프로필 사진과\n나를 표현하는 글을 선택해 주세요")
    
    private let profileImageView = DefaultProfileImageView()

    private lazy var cameraButton = UIButton().then {
        $0.setImage(.cameraIcon, for: .normal)
        $0.contentVerticalAlignment = .center
        $0.contentHorizontalAlignment = .center
    }
    
    private lazy var profileTextCollectionView = ProfileTextCollectionView(
        self,
        layout: ProfileTextCollectionViewLayout.layout()
    )
    
    private let nextButton = DefaultButton(title: "다음")
    
    // MARK: Properties
    
    private let profileViewModel: ProfileViewModel
    private lazy var imagePickerController = ImagePickerController()
    
    // MARK: - Initializer
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    private func setNextButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.setButtonBackgroundColor(isEnabled)
    }
    
    override func setting() {
        setNextButton(isEnabled: false)
        imagePickerController.delegate = self
    }
    
    override func bind() {
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
        
        profileTextCollectionView.rx.itemSelected
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.setNextButton(isEnabled: true)
            }
            .disposed(by: disposeBag)
        
        let imageObservable = cameraButton.rx.tap
            .withUnretained(self)
            .flatMapLatest { owner, _ in
                owner.imagePickerController.pickImage(allowsEditing: true)
            }
            .share()
        
        imageObservable
            .bind(to: profileImageView.rx.image)
            .disposed(by: disposeBag)
        
        let input = ProfileViewModel.Input(
            configureCollectionView: Single<Void>.just(()).asObservable(),
            profileImage: imageObservable.map { $0.jpegData(compressionQuality: 1.0) }
        )
        
        let output = profileViewModel.transform(input: input)
        
        output.configureCollectionViewData
            .withUnretained(self)
            .subscribe { owner, profileTexts in
                owner.profileTextCollectionView.setData(profileTexts)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(cameraButton)
        view.addSubview(profileTextCollectionView)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding48)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Constant.profileWidth)
        }
        
        cameraButton.snp.makeConstraints { make in
            make.right.equalTo(profileImageView.snp.right).offset(Constant.padding10)
            make.bottom.equalTo(profileImageView.snp.bottom).offset(Constant.padding10)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(Constant.padding24)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        profileTextCollectionView.snp.makeConstraints { make in
            make.top.equalTo(cameraButton.snp.bottom).offset(Constant.padding32)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(nextButton.snp.top)
        }
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
}
