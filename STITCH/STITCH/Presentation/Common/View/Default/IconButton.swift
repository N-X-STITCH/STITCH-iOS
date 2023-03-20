//
//  LoginButton.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import UIKit

enum IconButtonType {
    case kakao
    case apple
    case start
    case location
    case matchJoin
    case matchJoined
    
    var text: String {
        switch self {
        case .kakao: return "카카오로 로그인"
        case .apple: return "Apple로 로그인"
        case .start: return "시작하기"
        case .location: return "상현동"
        case .matchJoin: return "매치 참여하기"
        case .matchJoined: return "현재 참여하고 있는 매치"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .kakao: return .kakaoLogo
        case .apple: return .appleLogo
        case .start: return .myMatchSelect?.withTintColor(.gray12)
        case .location: return .arrowDown
        case .matchJoin: return .myMatchSelect?.withTintColor(.gray12)
        case .matchJoined: return nil
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .kakao: return UIColor(red: 0.996, green: 0.898, blue: 0, alpha: 1)
        case .apple: return .white
        case .start: return .yellow05_primary
        case .location: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        case .matchJoin: return .yellow05_primary
        case .matchJoined: return .gray12
        }
    }
    
    var direction: NSDirectionalRectEdge {
        switch self {
        case .kakao: return .leading
        case .apple: return .leading
        case .start: return .leading
        case .location: return .trailing
        case .matchJoin: return .leading
        case .matchJoined: return .leading
        }
    }
    
    var font: UIFont? {
        switch self {
        case .kakao: return .Body1_16
        case .apple: return .Body1_16
        case .start: return .Body1_16
        case .location: return .Subhead2_20
        case .matchJoin: return .Body1_16
        case .matchJoined: return .Body1_16
        }
    }
    
    var fontColor: UIColor? {
        switch self {
        case .kakao: return .systemBackground
        case .apple: return .systemBackground
        case .start: return .systemBackground
        case .location: return .white
        case .matchJoin: return .gray12
        case .matchJoined: return .gray07
        }
    }
}

final class IconButton: UIButton {
    
    enum Constant {
        static let padding6 = 6
    }

    init(
        iconButtonType: IconButtonType
    ) {
        super.init(frame: .zero)
        set(iconButtonType: iconButtonType)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set(
        iconButtonType: IconButtonType,
        title: String? = nil
    ) {
        var attributedString = AttributedString(iconButtonType.text)
        if let title = title {
            attributedString = AttributedString(title)
        }
        attributedString.font = iconButtonType.font
        attributedString.foregroundColor = iconButtonType.fontColor

        var configuration = UIButton.Configuration.filled()
        configuration.titleAlignment = .center
        if let _ = iconButtonType.icon {
            configuration.image = iconButtonType.icon
            configuration.imagePlacement = iconButtonType.direction
            configuration.imagePadding = CGFloat(Constant.padding6)
        }
        configuration.baseBackgroundColor = iconButtonType.backgroundColor
        configuration.attributedTitle = attributedString
        configuration.cornerStyle = .capsule
        self.configuration = configuration
    }
    
    func set(text: String, _ iconButtonType: IconButtonType) {
        var attributedString = AttributedString(text)
        attributedString.font = iconButtonType.font
        attributedString.foregroundColor = iconButtonType.fontColor
        configuration?.attributedTitle = attributedString
    }
    
    func set(backgroundColor: UIColor?) {
        configuration?.baseBackgroundColor = backgroundColor
    }
    
    func changeButtonInMatchDetail(type: IconButtonType) {
        set(iconButtonType: type)
        if type == .matchJoin {
            isEnabled = true
        } else {
            isEnabled = false
        }
    }
}
