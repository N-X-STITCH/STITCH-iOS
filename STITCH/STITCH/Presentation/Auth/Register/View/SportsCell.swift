//
//  SportsCell.swift
//  STITCH
//
//  Created by neuli on 2023/02/22.
//

import UIKit

import SnapKit

final class SportsCell: BaseCollectionViewCell {
    
    enum Constant {
        static let width = 88
        static let iconWidth = 36
        static let radius12 = 12
        static let alpha = 0.6
        static let padding8 = 8
    }
    
    // MARK: - Properties
    
    let sportIconLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 36)
        $0.textAlignment = .center
    }
    
    let sportNameLabel = UILabel().then {
        $0.font = .Body2_14
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    private lazy var stackView = UIStackView(
        arrangedSubviews: [sportIconLabel, sportNameLabel]
    ).then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = CGFloat(Constant.padding8)
    }
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        contentView.backgroundColor = .gray12.withAlphaComponent(CGFloat(Constant.alpha))
        contentView.layer.cornerRadius = CGFloat(Constant.radius12)
        
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func set(sport: Sport) {
        sportIconLabel.text = sport.icon
        sportNameLabel.text = sport.name
    }
    
    func configure(_ isSelected: Bool) {
        if isSelected {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.yellow05_primary.cgColor
        } else {
            contentView.layer.borderWidth = 0
            contentView.layer.borderColor = nil
        }
    }
}
