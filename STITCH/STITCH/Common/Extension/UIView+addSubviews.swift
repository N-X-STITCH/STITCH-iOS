//
//  UIView+addSubviews.swift
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
}
