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
    
    // progressBar
    
    private let titleLabel = DefaultTitleLabel(text: "안녕하세요!\n닉네임을 알려주세요")
    
    private let nicknameTextFiled = DefaultTextField(placeholder: "10자 내로 입력해주세요")
    
    private let textFieldRowView = UIView().then {
        $0.backgroundColor = .gray09
    }
    
    private let validationLabel = UILabel().then {
        $0.text = ""
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
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    func focusTextField(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    override func bind() {
        nextButton.rx.tap
            .subscribe { [weak self] _ in
                self?.coordinatorPublisher.onNext(.next)
            }
            .disposed(by: disposeBag)
    }
    
    override func setting() {
        focusTextField(nicknameTextFiled)
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(titleLabel)
        view.addSubview(nicknameTextFiled)
        view.addSubview(textFieldRowView)
        view.addSubview(validationLabel)
        view.addSubview(textCountLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
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

