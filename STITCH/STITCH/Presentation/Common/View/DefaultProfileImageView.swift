//
//  DefaultProfileImageView.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

final class DefaultProfileImageView: UIImageView {

    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        image = UIImage(systemName: "person.crop.circle.fill")?
            .withTintColor(.white, renderingMode: .alwaysOriginal)
        contentMode = .scaleAspectFill
        backgroundColor = .gray09
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius = frame.height / 2
        layer.cornerRadius = cornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func setImage(at profileImageURL: URL?) {
//        let maxProfileImageSize = CGSize(width: 80, height: 80)
//        let downsamplingProcessor = DownsamplingImageProcessor(size: maxProfileImageSize)
//        self.kf.setImage(with: profileImageURL, options: [.processor(downsamplingProcessor)])
//    }
}
