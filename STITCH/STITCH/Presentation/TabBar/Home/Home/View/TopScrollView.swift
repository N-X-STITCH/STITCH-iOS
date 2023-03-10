//
//  TopScrollView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class TopScrollView: UIScrollView {
    
    // MARK: - Properties
    
    enum Constant {
        static let imageCount = 3
        static let imageHeight = 350
    }
    
    private let screen: CGRect?
    private let imageViews: [UIImageView] = [
        UIImageView().then { $0.contentMode = .scaleToFill },
        UIImageView().then { $0.contentMode = .scaleToFill },
        UIImageView().then { $0.contentMode = .scaleToFill }
    ]
    
    // MARK: - Initializer
    
    init(delegate: UIScrollViewDelegate, _ view: UIView) {
        screen = UIScreen.main.bounds
        super.init(frame: .zero)
        self.delegate = delegate
        contentSize = CGSize(
            width: (screen?.width ?? 0) * CGFloat(Constant.imageCount),
            height: CGFloat(Constant.imageHeight)
        )
        alwaysBounceVertical = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        isScrollEnabled = true
        isPagingEnabled = true
        contentInsetAdjustmentBehavior = .never
        bounces = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func setImages(imageURLs: [String] = [
        "https://trythis.co.kr/classes/userfiles/1599722127497_%EB%86%8D%EA%B5%AC.jpg.jpg",
        "https://trythis.co.kr/classes/userfiles/1599722127497_%EB%86%8D%EA%B5%AC.jpg.jpg",
        "https://trythis.co.kr/classes/userfiles/1599722127497_%EB%86%8D%EA%B5%AC.jpg.jpg"
    ]) {
        let imageRect = CGRect(
            x: screen?.origin.x ?? 0,
            y: screen?.origin.y ?? 0,
            width: screen?.width ?? 0 / CGFloat(Constant.imageCount),
            height: CGFloat(Constant.imageHeight)
        )
        for (index, imageURL) in imageURLs.enumerated() {
            guard let url = URL(string: imageURL) else { return }
            let imageView = imageViews[index]
            imageView.kf.setImage(with: url)
            imageView.frame = imageRect
            imageView.frame.origin.x = (screen?.width ?? 0) * CGFloat(index)
            addSubview(imageView)
        }
    }
}
