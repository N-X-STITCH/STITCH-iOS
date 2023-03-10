//
//  DefaultBadgeView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

class DefaultBadgeLabel: UILabel {
    
    // MARK: - Properties
    
    enum Constant {
        static let padding2 = 4
        static let padding8 = 8
        static let radius4 = 4
    }
    
    private let padding = UIEdgeInsets(
        top: CGFloat(Constant.padding2),
        left: CGFloat(Constant.padding8),
        bottom: CGFloat(Constant.padding2),
        right: CGFloat(Constant.padding8)
    )

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        if contentSize.height != 0 && contentSize.width != 0 {
            contentSize.height += padding.top + padding.bottom
            contentSize.width += padding.left + padding.right
        }
        return contentSize
    }
    
    // MARK: - Initializer
    
    init(
        text: String,
        textColor: UIColor = .yellow05_primary,
        backgroundColor: UIColor = .gray11,
        font: UIFont? = .Caption2_10
    ) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.backgroundColor = backgroundColor
        self.font = font
        clipsToBounds = true
        layer.cornerRadius = CGFloat(Constant.radius4)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
}
