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
        static let padding16 = 16
    }
    
    // MARK: - Properties
    
    private let titleLabel = UILabel().then {
        $0.text = "새롭게 열린 매치"
        $0.textColor = .white
        $0.font = .Headline_20
    }
    
    // MARK: - Methods
    
    override func configureUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
    }
}
