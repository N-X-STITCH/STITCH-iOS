//
//  DefaultIconLabelView.swift
//  STITCH
//
//  Created by neuli on 2023/03/10.
//

import UIKit

final class DefaultIconLabelView: UIView {
    
    enum Constant {
        static let iconWidth = 18
        static let padding8 = 8
        
    }
    
    private let iconImageView = UIImageView()
    let textLabel = DefaultTitleLabel(text: "", textColor: .gray02, font: .Body2_14)
    
    init(
        icon: UIImage?,
        text: String
    ) {
        super.init(frame: .zero)
        iconImageView.image = icon
        textLabel.text = text
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(iconImageView)
        addSubview(textLabel)
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(Constant.iconWidth)
            make.top.left.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(Constant.padding8)
            make.top.bottom.right.equalToSuperview()
        }
    }
    
    private func set(text: String) {
        textLabel.text = text
    }
}

