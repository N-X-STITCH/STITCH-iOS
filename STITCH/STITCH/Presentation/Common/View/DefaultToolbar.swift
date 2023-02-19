//
//  DefaultToolbar.swift
//  STITCH
//
//  Created by neuli on 2023/02/19.
//

import UIKit

final class DefaultToolbar: UIToolbar {
    
    enum Constant {
        static let height = 48
    }
    
    init(
        toolbarItem: UIBarButtonItem,
        textFiled: UITextField,
        viewWidth: CGFloat,
        viewHeight: CGFloat
    ) {
        super.init(frame: .zero)
        frame = CGRect(origin: .zero, size: CGSize(width: viewWidth, height: CGFloat(Constant.height)))
        barTintColor = .yellow05_primary
        isTranslucent = false
        items = [toolbarItem]
        textFiled.inputAccessoryView = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
