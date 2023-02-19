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
        disabledFontColor: UIColor? = .gray12,
        normalColor: UIColor? = .yellow05_primary,
//        highlightedColor: UIColor? = .yellow06_pressed,
        disabledColor: UIColor? = .gray12
    ) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = font
        setTitleColor(fontColor, for: .normal)
        setTitleColor(fontColor, for: .highlighted)
        setTitleColor(disabledColor, for: .disabled)
        backgroundColor = normalColor
        layer.cornerRadius = CGFloat(Constant.radius6)
//        setBackgroundColor(normalColor, for: .normal)
//        setBackgroundColor(highlightedColor, for: .highlighted)
//        setBackgroundColor(disabledColor, for: .disabled)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
