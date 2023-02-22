//
//  FindLocationViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/20.
//

import UIKit

import RxSwift

final class FindLocationViewController: BaseViewController {
    
    // MARK: - Properties
    
    enum Constant {
        static let textFieldHeight = 56
        static let rowHeight = 1
        static let buttonHeight = 32
        static let radius4 = 4
        static let padding2 = 2
        static let padding8 = 8
        static let padding16 = 16
        static let padding24 = 24
    }
    
    private let searchTextField = DefaultTextField(
        placeholder: "동명(읍, 면)으로 검색 (ex.서초동)"
    )
    
    private let searchButton = DefaultButton(title: " 현재위치로 찾기", font: .Caption1_12, icon: .gps)
    
    private let textFieldRowView = UIView().then {
        $0.backgroundColor = .gray09
    }
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func bind() {
        
    }
    
    override func configureUI() {
        view.backgroundColor = .background
        
        view.addSubview(searchTextField)
        view.addSubview(textFieldRowView)
        view.addSubview(searchButton)
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.layoutMarginsGuide.snp.top)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.textFieldHeight)
        }
        
        textFieldRowView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.rowHeight)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldRowView.snp.bottom).offset(Constant.padding16)
            make.left.right.equalToSuperview().inset(Constant.padding16)
            make.height.equalTo(Constant.buttonHeight)
        }
    }
}

