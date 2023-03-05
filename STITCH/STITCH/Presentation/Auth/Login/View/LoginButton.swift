//
//  LoginButton.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import UIKit

enum LoginButtonType {
    case kakao
    case apple
    
    var text: String {
        switch self {
        case .kakao: return "카카오로 로그인"
        case .apple: return "Apple로 로그인"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .kakao: return .kakaoLogo
        case .apple: return .appleLogo
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .kakao: return UIColor(red: 0.996, green: 0.898, blue: 0, alpha: 1)
        case .apple: return .white
        }
    }
}

final class LoginButton: UIButton {
    
    enum Constant {
        static let padding6 = 6
    }

    init(
        loginButtonType: LoginButtonType
    ) {
        super.init(frame: .zero)

        var attributedString = AttributedString(loginButtonType.text)
        attributedString.font = .Body1_16
        attributedString.foregroundColor = .systemBackground

        var configuration = UIButton.Configuration.filled()
        configuration.titleAlignment = .center
        configuration.image = loginButtonType.icon
        configuration.imagePlacement = .leading
        configuration.imagePadding = CGFloat(Constant.padding6)
        configuration.baseBackgroundColor = loginButtonType.backgroundColor
        configuration.attributedTitle = attributedString
        configuration.cornerStyle = .capsule
        self.configuration = configuration
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
