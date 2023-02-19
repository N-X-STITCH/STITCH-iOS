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
        static let height = 55
    }

//    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
//        var padding = super.rightViewRect(forBounds: bounds)
//        padding.origin.x -= Constant.space16.cgFloat
//        return padding
//    }

    init(
        placeholder: String,
        searchTextFiled: Bool = false
    ) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        layer.borderWidth = 0
        font = .Body1_16
        textColor = .white
        clearButtonMode = .always
        if searchTextFiled {
            addLeftPadding()
        } else {
            addLeftPadding()
        }
        setPlaceHolderColor(placeholder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLeftPadding() {
        leftView = paddingView()
        leftViewMode = .always
    }

    private func paddingView() -> UIView {
        return UIView(frame: CGRect(
            x: Constant.zero,
            y: Constant.zero,
            width: Constant.padding8,
            height: Int(frame.height)
        ))
    }
    
    func setPlaceHolderColor(_ text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text, attributes: [.foregroundColor: UIColor.gray09]
        )
    }
}
