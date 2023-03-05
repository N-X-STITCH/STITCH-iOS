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
    
    var text: String {
        switch self {
        case .kakao: return "카카오로 로그인"
        case .apple: return "Apple로 로그인"
        case .start: return "시작하기"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .kakao: return .kakaoLogo
        case .apple: return .appleLogo
        case .start: return .myMatchSelect?.withTintColor(.gray12)
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .kakao: return UIColor(red: 0.996, green: 0.898, blue: 0, alpha: 1)
        case .apple: return .white
        case .start: return .yellow05_primary
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

        var attributedString = AttributedString(iconButtonType.text)
        attributedString.font = .Body1_16
        attributedString.foregroundColor = .systemBackground

        var configuration = UIButton.Configuration.filled()
        configuration.titleAlignment = .center
        configuration.image = iconButtonType.icon
        configuration.imagePlacement = .leading
        configuration.imagePadding = CGFloat(Constant.padding6)
        configuration.baseBackgroundColor = iconButtonType.backgroundColor
        configuration.attributedTitle = attributedString
        configuration.cornerStyle = .capsule
        self.configuration = configuration
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
