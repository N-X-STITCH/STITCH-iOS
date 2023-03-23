//
//  LoginViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import AuthenticationServices
import SafariServices
import UIKit

import RxSwift
import RxCocoa

final class LoginViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let width = 328
        static let buttonHeight = 48
        static let imageWidth = 38
        static let imageHeight = 35
        static let stitchLogoWidth = 124
        static let stitchLogoHeight = 26
        static let paading12 = 12
        static let paading16 = 16
        static let paading20 = 20
        static let paading24 = 24
        static let padding32 = 32
    }
    
    private let logoImageView = UIImageView(image: .logo)
    
    private let stitchLogoImageView = UIImageView(image: .stitchLogo)
    
    private let waveBackgroundView = UIImageView(image: .waveBackground)
    
    private let startLabel = UILabel().then {
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.34
        $0.attributedText = NSMutableAttributedString(
            string: "일상속에서 함께하는\n운동의 즐거움을 새롭게 경험해보세요",
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        $0.numberOfLines = 0
        $0.font = .Subhead2_20
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    private let useTermsButton = UIButton().then {
        $0.backgroundColor = .clear
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
    
    private let kakaoLoginButton = IconButton(iconButtonType: .kakao)
    
    private let appleLoginButton = IconButton(iconButtonType: .apple)
    
    // MARK: Properties
    
    private let loginViewModel: LoginViewModel
    private let signupViewModel: SignupViewModel
    
    private lazy var kakaoLoginService: SocialLoginService = KakaoLoginService()
    private lazy var appleLoginService: SocialLoginService = AppleLoginService(self)
    
    // MARK: - Initializer
    
    init(
        loginViewModel: LoginViewModel,
        signupViewModel: SignupViewModel
    ) {
        self.loginViewModel = loginViewModel
        self.signupViewModel = signupViewModel
        super.init()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addBackgroundGradient()
    }
    
    // MARK: - Methods
    
    override func bind() {
        useTermsButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.openPrivacyPolicy()
            }
            .disposed(by: disposeBag)
        
        let kakaoLogin = kakaoLoginButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .flatMap { _ in return self.kakaoLoginService.login() }
            .share()

        let appleLogin = appleLoginButton.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .flatMap { _ in return self.appleLoginService.login() }
            .share()
        
        let login = Observable.of(kakaoLogin, appleLogin).merge()
            .share()
        
        login
            .withUnretained(self)
            .subscribe (onNext: { owner, loginInfo in
                print("로그인됨", loginInfo)
                owner.signupViewModel.loginInfo = loginInfo
                owner.kakaoLoginService.initializeLoginInfo()
                owner.appleLoginService.initializeLoginInfo()
            }, onError: { [weak self] error in
                self?.handle(error: error)
            })
            .disposed(by: disposeBag)
        
        let loginInput = LoginViewModel.Input(loginInfo: login)
        let loginOutput = loginViewModel.transform(input: loginInput)
        
        loginOutput.signupedUser
            .withUnretained(self)
            .subscribe { owner, isSignuped in
                print("가입이 되었는지", isSignuped)
                if isSignuped {
                    owner.coordinatorPublisher.onNext(.showHome)
                } else {
                    owner.coordinatorPublisher.onNext(.next)
                }
            }
            .disposed(by: disposeBag)
        
        loginOutput.saveSocialLoginType
            .withUnretained(self)
            .subscribe { owner, _ in
                print("로그인 타입 저장됨")
            }
            .disposed(by: disposeBag)
        
        
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(waveBackgroundView)
        view.addSubview(logoImageView)
        view.addSubview(stitchLogoImageView)
        view.addSubview(useTermsLabel)
        view.addSubview(useTermsButton)
        view.addSubview(appleLoginButton)
        view.addSubview(kakaoLoginButton)
        view.addSubview(startLabel)
        
        waveBackgroundView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height / 3)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding32)
            make.left.equalToSuperview().offset(Constant.paading16)
            make.width.equalTo(Constant.imageWidth)
            make.height.equalTo(Constant.imageHeight)
        }
        
        stitchLogoImageView.snp.makeConstraints { make in
            make.left.equalTo(logoImageView.snp.right).offset(Constant.paading12)
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.width.equalTo(Constant.stitchLogoWidth)
            make.height.equalTo(Constant.stitchLogoHeight)
        }
        
        startLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.top.equalTo(logoImageView.snp.bottom).offset(Constant.paading24)
        }
        
        useTermsLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-Constant.paading20)
        }
        
        useTermsButton.snp.makeConstraints { make in
            make.edges.equalTo(useTermsLabel)
        }
        
        appleLoginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.bottom.equalTo(useTermsLabel.snp.top).offset(-Constant.paading24)
            make.height.equalTo(Constant.buttonHeight)
        }
        
        kakaoLoginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.paading16)
            make.right.equalToSuperview().offset(-Constant.paading16)
            make.bottom.equalTo(appleLoginButton.snp.top).offset(-Constant.paading12)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
    
    private func addBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
          UIColor(red: 0.102, green: 0.102, blue: 0.102, alpha: 1).cgColor,
          UIColor(red: 0.205, green: 0.208, blue: 0.213, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 0.88, b: 1.02, c: -1.02, d: 0.28, tx: 0.56, ty: -0.16)
        )
        gradientLayer.bounds = view.bounds.insetBy(
            dx: -0.5 * view.bounds.size.width,
            dy: -0.5 * view.bounds.size.height
        )
        gradientLayer.position = view.center

        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func openPrivacyPolicy() {
        guard let url = URL(string: "https://equal-quail-9cc.notion.site/2c5c89013b0b4bac8b3a7e67f597448e") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
}
