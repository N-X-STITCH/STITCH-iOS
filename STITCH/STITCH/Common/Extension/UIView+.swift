//
//  UIView+.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { [unowned self] in
            self.addSubview($0)
        }
    }
    
    func set(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func updateBackgroundColor(isEditing: Bool) {
        DispatchQueue.main.async {
            self.backgroundColor = isEditing ? .yellow05_primary : .gray09
        }
    }
}
