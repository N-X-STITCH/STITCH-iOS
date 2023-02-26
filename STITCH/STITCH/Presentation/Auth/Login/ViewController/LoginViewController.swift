//
//  LoginViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let width = 328
        static let buttonHeight = 48
        static let imageHeight = 142
        static let paading12 = 12
        static let paading16 = 16
        static let paading20 = 20
        static let paading24 = 24
        static let padding80 = 80
    }
    
    private let logoImageView = UIImageView().then {
        $0.image = UIImage(systemName: "heart.fill")
    }
    
    private let startLabel = UILabel().then {
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.44
        $0.attributedText = NSMutableAttributedString(
            string: NSLocalizedString("Start", comment: ""),
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        $0.numberOfLines = 0
        $0.font = .Body2_14
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private let useTermsLabel = UILabel().then {
        $0.textColor = .gray09
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        let attributedText = NSMutableAttributedString(
            string: NSLocalizedString("UseTerms", comment: ""),
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        attributedText.addAttribute(
            .foregroundColor,
            value: UIColor.gray06,
            range: (NSLocalizedString("UseTerms", comment: "") as NSString).range(of: "서비스 약관")
        )
        attributedText.addAttribute(
            .foregroundColor,
            value: UIColor.gray06,
            range: (NSLocalizedString("UseTerms", comment: "") as NSString).range(of: "개인정보 처리방침")
        )
        $0.attributedText = attributedText
        $0.numberOfLines = 0
        $0.font = .Caption2_10
        $0.textAlignment = .center
    }
    
    private let kakaoLoginButton = UIButton().then {
        $0.setImage(.kakaoLoginButton, for: .normal)
    }
    
    private let appleLoginButton = UIButton().then {
        $0.setImage(.appleLoginButton, for: .normal)
    }
    
    private let loginViewModel: LoginViewModel
    
    // MARK: - Initializer
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func bind() {
        kakaoLoginButton.rx.tap
            .subscribe { [weak self] _ in
                self?.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(logoImageView)
        view.addSubview(useTermsLabel)
        view.addSubview(appleLoginButton)
        view.addSubview(kakaoLoginButton)
        view.addSubview(startLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constant.padding80)
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.height.equalTo(Constant.imageHeight)
        }
        
        useTermsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-Constant.paading20)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.bottom.equalTo(useTermsLabel.snp.top).offset(-Constant.paading24)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-Constant.paading12)
        }
        
        startLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-Constant.paading12)
        }
    }
}
