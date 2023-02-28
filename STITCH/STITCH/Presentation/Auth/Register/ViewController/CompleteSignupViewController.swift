//
//  CompleteSignupViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import RxSwift

final class CompleteSignupViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let barHeight = 4
        static let buttonHeight = 56
        static let imageHeight = 220
        static let padding16 = 16
        static let padding24 = 24
    }
    
    private let titleLabel = UILabel().then {
        let text = "가입이 완료되었습니다!\nSTITCH를 통해 새로운 사람들과\n매칭을 즐겨보세요"
        $0.textColor = .white
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.17
        let attributedText = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        attributedText.addAttribute(
            .foregroundColor,
            value: UIColor.yellow05_primary,
            range: (text as NSString).range(of: "STITCH")
        )
        $0.attributedText = attributedText
        $0.numberOfLines = 0
        $0.font = .Headline_20
        $0.textAlignment = .left
    }
    
    private let startImageView = UIImageView().then {
        $0.image = .home2
    }
    
    private let nextButton = DefaultButton(title: "⚡️ 시작하기")
    
    // MARK: Properties
    
    private let signupViewModel: SignupViewModel
    
    // MARK: - Initializer
    
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func bind() {
        nextButton.rx.tap
            .subscribe { [weak self] _ in
                self?.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(startImageView)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
        }
        
        startImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.imageHeight)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(Constant.padding24)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
}
