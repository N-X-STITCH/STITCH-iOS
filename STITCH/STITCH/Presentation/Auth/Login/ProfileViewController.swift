//
//  ProfileViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import RxSwift

final class ProfileViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let profileWidth = 100
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
    
    private lazy var profileTextCollectionView = ProfileTextCollectionView(self)
    
    private let nextButton = DefaultButton(title: "다음")
    
    // TODO: 삭제
    private let testData = [
        "삶과 운동의 균형이 중요하다 생각해요",
        "새로운 사람들과 다양한 경험을 해보고 싶어요",
        "반복되는 일상에 특별함을 원해요",
        "경험을 통해 다양한 가치들을 얻는다고 생각해요",
        "삶과 운동의 균형이 중요하다 생각해요1",
        "새로운 사람들과 다양한 경험을 해보고 싶어요1",
        "반복되는 일상에 특별함을 원해요1",
        "경험을 통해 다양한 가치들을 얻는다고 생각해요1",
        "삶과 운동의 균형이 중요하다 생각해요2",
        "새로운 사람들과 다양한 경험을 해보고 싶어요2",
        "반복되는 일상에 특별함을 원해요2",
        "경험을 통해 다양한 가치들을 얻는다고 생각해요2",
        "삶과 운동의 균형이 중요하다 생각해요3",
        "새로운 사람들과 다양한 경험을 해보고 싶어요3",
        "반복되는 일상에 특별함을 원해요3",
        "경험을 통해 다양한 가치들을 얻는다고 생각해요3"
    ]
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func setting() {
        profileTextCollectionView.setData(testData)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(profileImageView)
        view.addSubview(cameraButton)
        view.addSubview(nextButton)
        view.addSubview(profileTextCollectionView)
        
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
