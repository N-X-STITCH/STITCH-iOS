//
//  MatchCell.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class MatchCell: BaseCollectionViewCell {
    
    static let reuseIdentifier = "MatchCell"
    
    enum Constant {
        static let padding4 = 4
        static let padding6 = 6
        static let padding12 = 12
        static let radius8 = 8
        static let imageWidth = 88
    }
    
    // MARK: - Properties
    
    private let matchImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    private let sportBadgeView = DefaultBadgeView()
    
    private let matchTitleLabel = UILabel().then {
        $0.text = "이번주 토요일에 탁구내기 한번?"
        $0.font = .Subhead_16
        $0.textColor = .gray02
    }
    
    private let matchInfoLabel = UILabel().then {
        $0.text = "성동구 | 02.02(월) 오후 3:00"
        $0.font = .Caption1_12
        $0.textColor = .gray04
    }
    
    private let peopleIconView = UIImageView().then {
        $0.image = .people
    }
    
    private let peopleCountLabel = UILabel().then {
        $0.text = "3/4명"
        $0.font = .Caption2_10
        $0.textColor = .gray04
    }
    
    // MARK: - Initializer
    
    // MARK: - Methods
    
    override func configureUI() {
        contentView.addSubview(matchImageView)
        contentView.addSubview(sportBadgeView)
        contentView.addSubview(matchTitleLabel)
        contentView.addSubview(matchInfoLabel)
        contentView.addSubview(peopleIconView)
        contentView.addSubview(peopleCountLabel)
        
        matchImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.width.height.equalTo(Constant.imageWidth)
        }
        
        sportBadgeView.set(matchType: .match, sport: .pingPong)
        sportBadgeView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(matchImageView.snp.right).offset(Constant.padding12)
        }
        
        matchTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(sportBadgeView.snp.bottom).offset(Constant.padding4)
            make.left.equalTo(matchImageView.snp.right).offset(Constant.padding12)
        }
        
        matchInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(matchTitleLabel.snp.bottom)
            make.left.equalTo(matchImageView.snp.right).offset(Constant.padding12)
        }
        
        peopleIconView.snp.makeConstraints { make in
            make.top.equalTo(matchInfoLabel.snp.bottom).offset(Constant.padding6)
            make.left.equalTo(matchImageView.snp.right).offset(Constant.padding12)
        }
        
        peopleCountLabel.snp.makeConstraints { make in
            make.left.equalTo(peopleIconView.snp.right).offset(Constant.padding4)
            make.centerY.equalTo(peopleIconView.snp.centerY)
        }
    }
    
    func setMatch(_ matchInfo: MatchInfo) {
        guard let url = URL(string: "https://blog.kakaocdn.net/dn/pbATv/btqxtXkCDlt/DwhLZCFllImV3OOYWassZ0/img.jpg") else { return }
        matchImageView.kf.setImage(with: url)
        // TODO: 추가
    }
}
