//
//  SportCategoryCell.swift
//  STITCH
//
//  Created by neuli on 2023/03/14.
//

import UIKit

import SnapKit

final class SportCategoryCell: BaseCollectionViewCell {
    
    enum Constant {
        static let padding4 = 4
        static let padding12 = 12
        static let padding16 = 16
        static let imageWidth = 52
        static let sportTitleHeight = 20
    }
    
    // MARK: - Properties
    
    static let reuseIdentifier = "SportCategoryCell"
    
    private let sportImageView = DefaultProfileImageView()
    
    private let sportTitleLabel = UILabel().then {
        $0.font = .Body2_14
        $0.textColor = .white
    }
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(sportImageView)
        contentView.addSubview(sportTitleLabel)
        
        sportImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.height.equalTo(Constant.imageWidth)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        sportTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(sportImageView.snp.bottom).offset(Constant.padding4)
            make.height.equalTo(Constant.sportTitleHeight)
        }
    }
    
    func set(sport: Sport) {
        sportImageView.image = sport.image
    }
    
    func configure(_ isSelected: Bool) {
        sportImageView.isGradient = isSelected
    }
}
