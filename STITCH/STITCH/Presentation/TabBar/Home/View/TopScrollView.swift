//
//  TopScrollView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class TopScrollView: UIScrollView {
    
    enum Constant {
        static let imageCount = 3
    }
    
    init(delegate: UIScrollViewDelegate, _ view: UIView) {
        super.init(frame: .zero)
        self.delegate = delegate
        let screen = view.window?.windowScene?.screen.bounds
        contentSize = CGSize(
            width: (screen?.width ?? 0) * CGFloat(Constant.imageCount),
            height: screen?.height ?? 0
        )
        alwaysBounceVertical = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isScrollEnabled = true
        isPagingEnabled = true
        bounces = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
