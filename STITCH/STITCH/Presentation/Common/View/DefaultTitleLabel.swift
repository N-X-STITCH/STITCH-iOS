//
//  DefaultTitleLabel.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit

final class DefaultTitleLabel: UILabel {
    init(
        text: String,
        textColor: UIColor? = .gray14,
        font: UIFont? = .Headline_20
    ) {
        super.init(frame: .zero)
        
        self.textColor = textColor
        self.font = font
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        textAlignment = .left
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.17
        
        attributedText = NSMutableAttributedString(
            string: text,
            attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )
        
        self.attributedText = attributedText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
