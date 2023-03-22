//
//  TopCollectionViewCell.swift
//  STITCH
//
//  Created by neuli on 2023/03/22.
//

import UIKit

import Kingfisher

final class TopCollectionViewCell: BaseCollectionViewCell {
    
    enum Constant {
    }
    
    // MARK: - Properties
    
    static let reuseIdentifier = "TopCollectionViewCell"
    
    private let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        contentView.backgroundColor = .clear
        
        contentView.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func configure(banner: BannerInfo) {
        backgroundImageView.image = banner.image
    }
}
