//
//  NicknameViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit

import RxSwift

final class NicknameViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let barHeight = 4
        static let buttonHeight = 48
        static let rowHeight = 1
        static let textFieldHeight = 56
        static let helperHeight = 18
        static let radius6 = 6
        static let padding2 = 2
        static let padding8 = 8
        static let padding16 = 16
        static let padding24 = 24
        static let padding40 = 40
    }
    
    private let progressView = DefaultProgressView(.nickname)
    
    private let titleLabel = DefaultTitleLabel(text: "안녕하세요!\n닉네임을 알려주세요")
    
    private let nicknameTextFiled = DefaultTextField(placeholder: "10자 내로 입력해주세요")
    
    private let textFieldRowView = UIView().then {
        $0.backgroundColor = .gray09
    }
    
    private let validationLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .error01
        $0.font = .Caption1_12
    }
    
    private let textCountLabel = UILabel().then {
        $0.text = "0 / 10"
        $0.textColor = .gray09
        $0.font = .Caption1_12
    }
    
    private let nextButton = DefaultButton(title: "다음")
    
    private lazy var nextButtonToolbarItem = UIBarButtonItem(customView: nextButton)
    
    private lazy var nextButtonToolbar = DefaultToolbar(
        toolbarItem: nextButtonToolbarItem,
        textFiled: nicknameTextFiled,
        viewWidth: view.frame.size.width,
        viewHeight: view.frame.size.height
    )
    
    private let nicknameViewModel: NicknameViewModel
    
    // MARK: - Initializer
    
    init(nicknameViewModel: NicknameViewModel) {
        self.nicknameViewModel = nicknameViewModel
        super.init()
    }
    
    // MARK: - Methods
    
    private func focusTextField(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    private func setValidation(_ validation: NicknameValidation) {
        validationLabel.text = validation.message
        setButtonIsEnabledColor(validation.isEnabled)
        
        switch validation {
        case .ok:
            textFieldRowView.backgroundColor = .yellow05_primary
            textCountLabel.textColor = .white
        default:
            textFieldRowView.backgroundColor = .error01
            textCountLabel.textColor = .error01
        }
    }
    
    private func setButtonIsEnabledColor(_ isEnabled: Bool) {
        nextButton.isEnabled = isEnabled
        nextButton.setButtonBackgroundColor(isEnabled)
        nextButtonToolbar.setButtonBackgroundColor(isEnabled)
    }
    
    override func bind() {
        nextButton.rx.tap
            .withUnretained(self)
            .subscribe { owner, _ in
                owner.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
        
        let textField = nicknameTextFiled.rx.text.share()
        
        textField
            .withUnretained(self)
            .subscribe { owner, text in
                owner.textCountLabel.text = "\(text?.count ?? 0) / 10"
            }
            .disposed(by: disposeBag)
        
        let input = NicknameViewModel.Input(
            nicknameTextFieldChanged: textField
                .compactMap { $0 }
                .filter { !$0.isEmpty }
                .distinctUntilChanged()
                .debounce(.milliseconds(10), scheduler: MainScheduler.asyncInstance)
                .asObservable()
        )
        
        let output = nicknameViewModel.transform(input: input)
        
        output.nicknameValidation
            .asObservable()
            .withUnretained(self)
            .subscribe { owner, validation in
                owner.setValidation(validation)
            }
            .disposed(by: disposeBag)
    }
    
    override func setting() {
        focusTextField(nicknameTextFiled)
        setButtonIsEnabledColor(false)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(progressView)
        view.addSubview(titleLabel)
        view.addSubview(nicknameTextFiled)
        view.addSubview(textFieldRowView)
        view.addSubview(validationLabel)
        view.addSubview(textCountLabel)
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.barHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(Constant.padding24)
            make.left.right.equalToSuperview().inset(Constant.padding16)
        }
        
        nicknameTextFiled.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        textFieldRowView.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextFiled.snp.bottom)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
            make.height.equalTo(Constant.rowHeight)
        }
        
        validationLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldRowView.snp.bottom).offset(Constant.padding2)
            make.left.equalTo(Constant.padding24)
            make.height.equalTo(Constant.helperHeight)
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldRowView.snp.bottom).offset(Constant.padding2)
            make.right.equalTo(-Constant.padding24)
            make.height.equalTo(Constant.helperHeight)
        }
        
        nextButtonToolbar.updateConstraintsIfNeeded()
    }
}

