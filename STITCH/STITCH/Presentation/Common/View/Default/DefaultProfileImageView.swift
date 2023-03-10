//
//  DefaultProfileImageView.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

final class DefaultProfileImageView: UIImageView {
    
    // MARK: - Properties
    
    enum Constant {
        static let lineWidth = 1
        static let gradationWidth = 2
    }
    
    var isGradient = false
    
    private lazy var gradientLayer = CAGradientLayer().then {
        $0.colors = [UIColor.yellow05_primary, UIColor.yellow07]
    }
    
    private lazy var shapeLayer = CAShapeLayer().then {
        $0.lineWidth = CGFloat(Constant.lineWidth)
        $0.strokeColor = UIColor.black.cgColor
        $0.fillColor = UIColor.clear.cgColor
    }
    
    // MARK: - Initializer

    init(_ isGradient: Bool = false) {
        super.init(frame: .zero)
        clipsToBounds = true
        image = UIImage(systemName: "person.crop.circle.fill")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        contentMode = .scaleAspectFill
        backgroundColor = .gray09
        
        self.isGradient = isGradient
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius = frame.height / 2
        layer.cornerRadius = cornerRadius
        
        if isGradient {
            gradientLayer.frame = bounds
            shapeLayer.path = UIBezierPath(
                roundedRect: bounds.insetBy(
                    dx: CGFloat(Constant.gradationWidth),
                    dy: CGFloat(Constant.gradationWidth)
                ),
                cornerRadius: bounds.height / 2.0
              ).cgPath
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
}
