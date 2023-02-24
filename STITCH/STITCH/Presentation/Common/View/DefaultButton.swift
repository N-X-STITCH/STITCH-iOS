//
//  DefaultButton.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit

final class DefaultButton: UIButton {
    
    enum Constant {
        static let radius6 = 6
    }
    
    init(
        title: String,
        font: UIFont? = .Body1_16,
        fontColor: UIColor? = .black,
        disabledFontColor: UIColor? = .white,
        normalColor: UIColor? = .yellow05_primary,
        icon: UIImage? = nil
    ) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = font
        setTitleColor(fontColor, for: .normal)
        setTitleColor(fontColor, for: .highlighted)
        setTitleColor(disabledFontColor, for: .disabled)
        backgroundColor = normalColor
        layer.cornerRadius = CGFloat(Constant.radius6)
        if let icon = icon {
            setImage(icon, for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButtonBackgroundColor(_ isEnabled: Bool) {
        backgroundColor = isEnabled ? .yellow05_primary : .gray12
    }
}
