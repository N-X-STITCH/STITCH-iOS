//
//  PopularHeaderView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class PopularHeaderView: BaseCollectionReusableView {
    
    enum Constant {
        static let padding16 = 16
        static let labelHeight = 28
    }
    
    static let reuseIdentifier = "PopularHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.text = "추천하는 Teach 매치"
        $0.textColor = .white
        $0.font = .Headline_20
    }
    
    override func configureUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(Constant.labelHeight)
        }
    }
}
