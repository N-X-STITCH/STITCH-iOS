//
//  DefaultTextField.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit

final class DefaultTextField: UITextField {
    
    enum Constant {
        static let zero = 0
        static let padding8 = 8
        static let searchGlassesWidth = 48
        static let height = 55
    }

//    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//        var padding = super.rightViewRect(forBounds: bounds)
//        padding.origin.x -= Constant.space16.cgFloat
//        return padding
//    }

    init(
        placeholder: String,
        leftView: Bool = false
    ) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        layer.borderWidth = 0
        font = .Body1_16
        textColor = .white
        clearButtonMode = .always
        setPlaceHolderColor(placeholder)
        
        if leftView {
            addLeftSearchGlassesView()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLeftSearchGlassesView() {
        let imageView = UIImageView(frame: CGRect(
            x: 0, y: 0, width: Constant.searchGlassesWidth, height: Constant.searchGlassesWidth)
        )
        imageView.image = .searchGlasses
        leftView = imageView
        leftViewMode = .always
    }

    private func paddingView(width: Int, height: Int) -> UIView {
        return UIView(frame: CGRect(
            x: Constant.zero,
            y: Constant.zero,
            width: width,
            height: height
        ))
    }
    
    func setPlaceHolderColor(_ text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text, attributes: [.foregroundColor: UIColor.gray09]
        )
    }
}
