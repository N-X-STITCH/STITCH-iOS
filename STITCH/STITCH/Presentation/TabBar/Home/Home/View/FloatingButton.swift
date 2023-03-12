//
//  FloatingButton.swift
//  STITCH
//
//  Created by neuli on 2023/03/05.
//

import UIKit

final class FloatingButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow05_primary
        setImage(.plus, for: .normal)
        clipsToBounds = true
        layer.cornerRadius = 28
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
