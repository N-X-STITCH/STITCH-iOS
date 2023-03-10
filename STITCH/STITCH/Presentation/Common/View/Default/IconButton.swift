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
    
    var text: String {
        switch self {
        case .kakao: return "카카오로 로그인"
        case .apple: return "Apple로 로그인"
        case .start: return "시작하기"
        case .location: return "상현동"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .kakao: return .kakaoLogo
        case .apple: return .appleLogo
        case .start: return .myMatchSelect?.withTintColor(.gray12)
        case .location: return .arrowDown
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .kakao: return UIColor(red: 0.996, green: 0.898, blue: 0, alpha: 1)
        case .apple: return .white
        case .start: return .yellow05_primary
        case .location: return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    var direction: NSDirectionalRectEdge {
        switch self {
        case .kakao: return .leading
        case .apple: return .leading
        case .start: return .leading
        case .location: return .trailing
        }
    }
    
    var font: UIFont? {
        switch self {
        case .kakao: return .Body1_16
        case .apple: return .Body1_16
        case .start: return .Body1_16
        case .location: return .Subhead2_20
        }
    }
    
    var fontColor: UIColor? {
        switch self {
        case .kakao: return .systemBackground
        case .apple: return .systemBackground
        case .start: return .systemBackground
        case .location: return .white
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
        configuration.image = iconButtonType.icon
        configuration.imagePlacement = iconButtonType.direction
        configuration.imagePadding = CGFloat(Constant.padding6)
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
}
