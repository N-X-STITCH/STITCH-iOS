//
//  NicknameViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit


final class NicknameViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let buttonHeight = 48
        static let rowHeight = 1
        static let textFieldHeight = 55
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
        $0.backgroundColor = .gray07
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
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(nicknameTextFiled)
        view.addSubview(textFieldRowView)
        view.addSubview(validationLabel)
        view.addSubview(textCountLabel)
        view.addSubview(nextButton)
        
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
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(-Constant.padding40)
            make.left.equalToSuperview().offset(Constant.padding16)
            make.right.equalToSuperview().offset(-Constant.padding16)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
}

