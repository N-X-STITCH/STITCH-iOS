//
//  ProfileTextCell.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

import SnapKit

final class ProfileTextCell: UICollectionViewCell {
    
    enum Constant {
        static let alpha = 50
        static let radius4 = 4
    }
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            configure(isSelected)
        }
    }
    
    private let label = UILabel().then {
        $0.font = .Caption1_12
        $0.textColor = .gray09
        $0.textAlignment = .center
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.layer.borderWidth = 0
        label.layer.borderColor = nil
    }
    
    func configureUI() {
        contentView.backgroundColor = .background
        
        contentView.addSubview(label)
        
        label.backgroundColor = .gray12.withAlphaComponent(CGFloat(Constant.alpha))
        label.clipsToBounds = true
        label.layer.cornerRadius = CGFloat(Constant.radius4)
        
        label.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setLabel(text: ProfileText) {
        label.text = text.text
    }
    
    func configure(_ isSelected: Bool) {
        if isSelected {
            label.layer.borderWidth = 1
            label.layer.borderColor = UIColor.yellow05_primary.cgColor
            label.textColor = .yellow05_primary
        } else {
            label.layer.borderWidth = 0
            label.layer.borderColor = nil
            label.textColor = .gray09
        }
    }
}
