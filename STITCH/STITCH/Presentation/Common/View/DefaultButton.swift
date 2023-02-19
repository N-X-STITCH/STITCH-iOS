//
//  DefaultButton.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit

final class DefaultButton: UIButton {
    
    init(
        title: String,
        font: UIFont? = .Body1_16,
        fontColor: UIColor? = .black,
        disabledFontColor: UIColor? = .gray12,
        normalColor: UIColor? = .blue05,
        highlightedColor: UIColor? = .blue06,
        disabledColor: UIColor? = .gray03
    ) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = font
        
        setTitleColor(fontColor, for: .normal)
        setTitleColor(fontColor, for: .highlighted)
        setTitleColor(disabledColor, for: .disabled)
        setBackgroundColor(normalColor, for: .normal)
        setBackgroundColor(highlightedColor, for: .highlighted)
        setBackgroundColor(disabledColor, for: .disabled)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
