//
//  TopScrollImageView.swift
//  STITCH
//
//  Created by neuli on 2023/03/02.
//

import UIKit

final class TopScrollImageView: BaseView {
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
}
