//
//  MatchScheduleInfoView.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import UIKit

final class MatchScheduleInfoView: UIView {
    
    enum Constant {
        static let padding6 = 6
        static let padding12 = 12
        static let radius12 = 12
        static let iconWidth = 16
    }
    
    // MARK: - Properties
    
    private let iconImageView = UIImageView(image: .infoCircle)
    private let infoLabel = UILabel().then {
        $0.text = "모임 3시간 전, 자동으로 신청이 마감됩니다."
        $0.textColor = .gray02
        $0.font = .Caption1_12
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
    
    private func configureUI() {
        backgroundColor = .gray12
        layer.cornerRadius = 12
        
        addSubviews([iconImageView, infoLabel])
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.padding12)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Constant.iconWidth)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(Constant.padding6)
            make.right.equalToSuperview().inset(Constant.padding12)
            make.centerY.equalToSuperview()
        }
    }
}
