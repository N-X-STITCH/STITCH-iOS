//
//  LocationViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import RxSwift

final class LocationViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let barHeight = 4
        static let buttonHeight = 48
        static let rowHeight = 1
        static let inputButtonHeight = 56
        static let helperHeight = 18
        static let stackViewHeight = 24
        static let radius6 = 6
        static let padding2 = 2
        static let padding8 = 8
        static let padding16 = 16
        static let padding24 = 24
        static let padding34 = 34
    }
    
    private let titleLabel = DefaultTitleLabel(text: "현재 거주하는\n위치를 설정해주세요")
    
    private let homeImageView = UIImageView().then {
        $0.tintColor = .white
        $0.image = .home2
    }
    
    private let homeLabel = UILabel().then {
        $0.text = "집"
        $0.textColor = .white
        $0.font = .Subhead_16
    }
    
    private lazy var homeStackView = UIStackView(
        arrangedSubviews: [homeImageView, homeLabel]
    ).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = CGFloat(Constant.padding8)
    }
    
    private let inputButton = DefaultButton(
        title: "  필수입력",
        fontColor: .gray09,
        normalColor: .background
    ).then {
        $0.contentHorizontalAlignment = .left
    }
    
    private let textFieldRowView = UIView().then {
        $0.backgroundColor = .gray09
    }
    
    private let nextButton = DefaultButton(title: "다음")
    
    // MARK: Propeties
    
    private let signupViewModel: SignupViewModel
    
    // MARK: - Initializer
    
    init(signupViewModel: SignupViewModel) {
        self.signupViewModel = signupViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    override func setting() {
        setNextButton(isEnabled: false)
    }
    
    override func bind() {
        
        inputButton.rx.tap
            .subscribe { [weak self] _ in
                self?.coordinatorPublisher.onNext(.findLocation)
            }
            .disposed(by: disposeBag)
        
        let signupInput = SignupViewModel.Input(
            signupButtonTap: nextButton.rx.tap.asObservable()
        )
        
        let signupOutput = signupViewModel.transform(signupInput)
        
        signupOutput.signupResult
            .withUnretained(self)
            .subscribe(on: MainScheduler.asyncInstance)
            .subscribe (onNext: { owner, _ in
                owner.coordinatorPublisher.onNext(.next)
            }, onError: { [weak self] error in
                self?.handle(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(homeStackView)
        view.addSubview(inputButton)
        view.addSubview(textFieldRowView)
        view.addSubview(nextButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
        }
        
        homeStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.height.equalTo(Constant.stackViewHeight)
        }
        
        inputButton.snp.makeConstraints { make in
            make.top.equalTo(homeStackView.snp.bottom)
            make.left.equalToSuperview().offset(Constant.padding34)
            make.right.equalToSuperview().offset(-Constant.padding16)
            make.height.equalTo(Constant.inputButtonHeight)
        }
        
        textFieldRowView.snp.makeConstraints { make in
            make.top.equalTo(inputButton.snp.bottom)
            make.left.right.equalTo(inputButton)
            make.height.equalTo(Constant.rowHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).inset(Constant.padding24)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
    
    private func setNextButton(isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.setButtonBackgroundColor(isEnabled)
    }
    
    func didReceive(locationInfo: LocationInfo) {
        signupViewModel.locationInfo = locationInfo
        inputButton.setTitle(locationInfo.address, for: .normal)
        inputButton.setTitleColor(.gray02, for: .normal)
        setNextButton(isEnabled: true)
    }
}
