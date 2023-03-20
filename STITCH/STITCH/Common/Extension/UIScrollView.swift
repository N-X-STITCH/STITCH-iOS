//
//  UIScrollView.swift
//  STITCH
//
//  Created by neuli on 2023/03/08.
//

import UIKit

extension UIScrollView {
    func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        return totalRect.union(view.frame)
    }
}
