//
//  MatchHeaderView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class MatchHeaderView: BaseCollectionReusableView {
    
    static let reuseIdentifier = "MatchHeaderView"
    
    enum Constant {
        static let lineHeight = 8
        static let padding16 = 16
        static let padding24 = 24
    }
    
    // MARK: - Properties
    
    private let lineView = UIView().then {
        $0.backgroundColor = .gray12
    }
    
    let titleLabel = UILabel().then {
        $0.text = "새롭게 열린 매치"
        $0.textColor = .white
        $0.font = .Headline_20
    }
    
    // MARK: - Methods
    
    override func configureUI() {
        backgroundColor = .background
        addSubview(lineView)
        addSubview(titleLabel)
        
        lineView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(Constant.lineHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(Constant.padding24)
            make.left.equalToSuperview().offset(Constant.padding16)
        }
    }
    
    func setup(title text: String) {
        titleLabel.text = text
    }
}
