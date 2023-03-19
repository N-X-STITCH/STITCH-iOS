//
//  PopularMatchCell.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

import Kingfisher

final class PopularMatchCell: BaseCollectionViewCell {
    
    enum Constant {
        static let padding4 = 4
        static let padding6 = 6
        static let padding8 = 8
        static let padding14 = 14
        static let padding16 = 16
        static let padding20 = 20
        static let radius24 = 28
        static let profileWidth = 36
        static let labelHeight18 = 18
        static let labelHeight24 = 24
        static let iconWidth = 24
        static let bottomGradientViewHeight = 120
    }
    
    // MARK: - Properties
    
    static let reuseIdentifier = "PopularMatchCell"
    
    private let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    private let bottomGradientView = UIImageView(image: .smallBottomGradientView)
    
    private let profileImageView = DefaultProfileImageView(true)
    
    private let nicknameLabel = UILabel().then {
        $0.text = "good"
        $0.textColor = .white
        $0.font = .Subhead2_14
    }
    
    private lazy var classBadgeView = ClassBadge()
    
    private let sportBadgeView = SportBadge(sport: .etc)
    
    private let titleLabel = UILabel().then {
        $0.text = "이번주 토요일 테니스"
        $0.textColor = .white
        $0.font = .Subhead_16
    }
    
    private let matchInfoLabel = UILabel().then {
        $0.text = "성동구 | 02.02(월) 오후 3:00"
        $0.textColor = .white
        $0.font = .Caption1_12
    }
    
    private let peopleIconView = UIImageView().then {
        $0.image = .userIcon
    }
    
    private let peopleCountLabel = UILabel().then {
        $0.text = "3/4명"
        $0.textColor = .white
        $0.font = .Body2_14
    }
    
    // peopleView
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        contentView.backgroundColor = .yellow05_primary
        contentView.layer.cornerRadius = CGFloat(Constant.radius24)
        contentView.clipsToBounds = true
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(bottomGradientView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nicknameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(matchInfoLabel)
        contentView.addSubview(peopleIconView)
        contentView.addSubview(peopleCountLabel)
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        bottomGradientView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(Constant.bottomGradientViewHeight)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Constant.padding14)
            make.width.height.equalTo(Constant.profileWidth)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImageView.snp.right).offset(Constant.padding8)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
        
        peopleIconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.padding16)
            make.bottom.equalToSuperview().inset(Constant.padding20)
            make.width.height.equalTo(Constant.iconWidth)
        }
        
        peopleCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(peopleIconView.snp.centerY)
            make.left.equalTo(peopleIconView.snp.right).offset(Constant.padding4)
        }
        
        matchInfoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.padding16)
            make.bottom.equalTo(peopleIconView.snp.top).offset(-Constant.padding8)
            make.height.equalTo(Constant.labelHeight18)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constant.padding16)
            make.bottom.equalTo(matchInfoLabel.snp.top)
            make.height.equalTo(Constant.labelHeight24)
        }
    }
    
    private func setBadgeConstraint(badgeView: UIView) {
        addSubview(badgeView)
        badgeView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-Constant.padding8)
            make.left.equalToSuperview().offset(Constant.padding16)
        }
    }
    
    private func setBadge(match: Match) {
        sportBadgeView.set(sport: match.sport)
        switch match.matchType {
        case .teachMatch:
            let stackView = UIStackView(arrangedSubviews: [classBadgeView, sportBadgeView]).then {
                $0.axis = .horizontal
                $0.spacing = CGFloat(Constant.padding6)
            }
            setBadgeConstraint(badgeView: stackView)
        default:
            setBadgeConstraint(badgeView: sportBadgeView)
        }
    }
    
    func setMatch(_ matchInfo: MatchInfo) {
        let match = matchInfo.match
        let owner = matchInfo.owner
        
        nicknameLabel.text = owner.nickname
        
        setBadge(match: match)
        
        guard let url = URL(string: "https://blog.kakaocdn.net/dn/pbATv/btqxtXkCDlt/DwhLZCFllImV3OOYWassZ0/img.jpg") else { return }
        backgroundImageView.kf.setImage(with: url)
        // TODO: 추가
    }
}
