//
//  DefaultBadgeView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class DefaultBadgeView: UIView {
    
    // MARK: - Properties
    
    enum Constant {
        static let radius4 = 4
        static let padding6 = 6
    }
    
    private let classBadge = UILabel().then {
        $0.text = "클래스"
        $0.textColor = .gray12
        $0.font = .Caption2_10
        $0.layer.cornerRadius = CGFloat(Constant.radius4)
        $0.backgroundColor = .yellow05_primary
    }
    
    private let sportBadge = UILabel().then {
        $0.text = "운동"
        $0.textColor = .yellow05_primary
        $0.font = .Caption2_10
        $0.layer.cornerRadius = CGFloat(Constant.radius4)
        $0.backgroundColor = .gray11
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func configureUI(_ view: UIView) {
        addSubview(view)
        view.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func set(matchType: MatchType, sport: Sport) {
        switch matchType {
        case .match:
            sportBadge.text = sport.name
            configureUI(sportBadge)
        case .classMatch:
            sportBadge.text = sport.name
            let stackView = UIStackView(arrangedSubviews: [classBadge, sportBadge]).then {
                $0.spacing = CGFloat(Constant.padding6)
                $0.alignment = .fill
                $0.distribution = .equalSpacing
                $0.axis = .horizontal
            }
            configureUI(stackView)
        }
    }
}
