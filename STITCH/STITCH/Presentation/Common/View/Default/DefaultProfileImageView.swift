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
    
    var isGradient = false {
        didSet {
            set(isLayer: isGradient)
        }
    }
    
    // MARK: - Initializer

    init(_ isGradient: Bool = false) {
        super.init(frame: .zero)
        clipsToBounds = true
        image = UIImage(systemName: "circle.fill")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        contentMode = .scaleAspectFill
        backgroundColor = .clear
        layer.borderColor = UIColor.yellow05_primary.cgColor
        
        self.isGradient = isGradient
        set(isLayer: isGradient)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius = frame.height / 2
        layer.cornerRadius = cornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func set(isLayer: Bool) {
        if isLayer {
            layer.borderWidth = 1
        } else if layer.superlayer != nil {
            layer.borderWidth = 0
        }
    }
}
