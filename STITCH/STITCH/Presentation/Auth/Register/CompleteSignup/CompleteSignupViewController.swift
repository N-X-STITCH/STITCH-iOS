//
//  CompleteSignupViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import Lottie
import RxSwift

final class CompleteSignupViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let barHeight = 4
        static let buttonHeight = 56
        static let imageWidth = 270
        static let imageHeight = 224
        static let fireworksWidth = 360
        static let padding16 = 16
        static let padding24 = 24
        static let padding48 = 48
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
    
    private let fireworksView = LottieAnimationView(name: "fireworks")
    
    private let startImageView = UIImageView(image: .completeSignup)
    
    private let nextButton = IconButton(iconButtonType: .start)
    
    // MARK: Properties
    
    private let signupViewModel: SignupViewModel
    
    // MARK: - Initializer
    
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
        super.init()
    }
    
    override func viewDidLayoutSubviews() {
        // TODO: 작동
        // addGradientLayerToButton()
    }
    
    // MARK: - Methods
    
    override func setting() {
        setAnimation()
    }
    
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
        view.insertSubview(fireworksView, belowSubview: startImageView)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
        }
        
        startImageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding48)
            make.centerY.equalToSuperview().offset(Constant.padding24)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(Constant.padding24)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
    
    private func setAnimation() {
        fireworksView.bounds = CGRect(x: 0, y: 0, width: Constant.fireworksWidth, height: Constant.fireworksWidth)
        fireworksView.center = view.center
        fireworksView.contentMode = .scaleAspectFill
        fireworksView.loopMode = .loop
        fireworksView.play()
    }
    
    private func addGradientLayerToButton() {
        let gradientLayer = CAGradientLayer()

        gradientLayer.colors = [
          UIColor(red: 1, green: 1, blue: 0, alpha: 1).cgColor,
          UIColor(red: 1, green: 0.78, blue: 0, alpha: 1).cgColor
        ]

        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradientLayer.transform = CATransform3DMakeAffineTransform(
            CGAffineTransform(a: 1, b: -0.94, c: 0.94, d: 4, tx: -0.47, ty: -1)
        )
        gradientLayer.bounds = nextButton.bounds.insetBy(
            dx: -0.5 * nextButton.bounds.size.width,
            dy: -0.5 * nextButton.bounds.size.height
        )
        gradientLayer.position = nextButton.center
        nextButton.layer.addSublayer(gradientLayer)
        nextButton.layer.cornerRadius = CGFloat(Constant.buttonHeight / 2)
    }
}
