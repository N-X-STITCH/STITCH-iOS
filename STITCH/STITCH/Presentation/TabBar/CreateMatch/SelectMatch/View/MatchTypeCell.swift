//
//  MatchTypeCell.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import UIKit

import SnapKit

enum CreateMatchType: CaseIterable {
    case normal, teach
    
    var icon: UIImage? {
        switch self {
        case .normal: return .flashCircle
        case .teach: return .userCircle
        }
    }
    
    var matchTitle: String {
        switch self {
        case .normal: return "일반 매치개설"
        case .teach: return "티치 매치개설"
        }
    }
    
    var explainMatch: String {
        switch self {
        case .normal: return "누구나 참여할 수 있는 매치를 열어보세요"
        case .teach: return "전문적인 수강을 위한 매치를 열어보세요"
        }
    }
}

final class MatchTypeCell: UICollectionViewCell {
    
    enum Constant {
        static let radius24 = 24
        static let alpha = 0.6
        static let padding2 = 2
        static let padding12 = 12
        static let padding16 = 16
        static let padding18 = 18
        static let iconWidth = 48
        static let matchTitleHeight = 24
        static let explainMatchHeight = 18
    }
    
    // MARK: - Properties
    
    static let reuseIdentifier = "MatchTypeCell"
    
    private var matchType: CreateMatchType!
    
    private let matchIconView = UIImageView(image: .flashCircle)
    
    private let matchTitleLabel = UILabel().then {
        $0.font = .Subhead_16
        $0.textColor = .gray09
    }
    
    private let explainMatchLabel = UILabel().then {
        $0.font = .Caption1_12
        $0.textColor = .gray09
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
        contentView.backgroundColor = .gray12.withAlphaComponent(CGFloat(Constant.alpha))
        contentView.layer.cornerRadius = CGFloat(Constant.radius24)
        
        contentView.addSubview(matchIconView)
        contentView.addSubview(matchTitleLabel)
        contentView.addSubview(explainMatchLabel)
        
        matchIconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.padding16)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        matchTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(matchIconView.snp.right).offset(Constant.padding12)
            make.top.equalTo(contentView.snp.top).offset(Constant.padding18)
            make.height.equalTo(Constant.matchTitleHeight)
        }
        
        explainMatchLabel.snp.makeConstraints { make in
            make.top.equalTo(matchTitleLabel.snp.bottom).offset(Constant.padding2)
            make.left.equalTo(matchTitleLabel.snp.left)
            make.height.equalTo(Constant.explainMatchHeight)
        }
    }
    
    func set(matchType: CreateMatchType) {
        self.matchType = matchType
        matchIconView.image = matchType.icon
        matchTitleLabel.text = matchType.matchTitle
        explainMatchLabel.text = matchType.explainMatch
    }
    
    func configure(_ isSelected: Bool) {
        if isSelected {
            contentView.backgroundColor = .gray11
            matchIconView.image = matchType.icon?.withTintColor(.yellow05_primary)
            matchTitleLabel.textColor = .white
            explainMatchLabel.textColor = .white
        } else {
            contentView.backgroundColor = .gray12.withAlphaComponent(CGFloat(Constant.alpha))
            matchIconView.image = matchType.icon
            matchTitleLabel.textColor = .gray09
            explainMatchLabel.textColor = .gray09
        }
    }
}
