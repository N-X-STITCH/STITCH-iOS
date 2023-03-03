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
    }
    
    static let reuseIdentifier = "PopularHeaderView"
    
    private let titleLabel = UILabel().then {
        $0.text = "지금 인기있는 매치"
        $0.textColor = .white
        $0.font = .Headline_20
    }
    
    let viewAllButton = UIButton().then {
        $0.titleLabel?.font = .Body2_14
        $0.setTitleColor(.gray07, for: .normal)
        $0.setTitle("전체보기", for: .normal)
    }
    
    override func configureUI() {
        addSubview(titleLabel)
        addSubview(viewAllButton)
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        viewAllButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Constant.padding16)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}
