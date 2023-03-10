//
//  DefaultTextView.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

final class DefaultTextView: UITextView {
    
    enum Constant {
        static let padding6 = 6
        static let padding8 = 8
    }
    
    // MARK: - Properties
    
    private let placeholderLabel = UILabel()
    
    // MARK: - Initializer

    init(
        placeholder: String
    ) {
        super.init(frame: .zero, textContainer: nil)
        configure(placeholder: placeholder)
        backgroundColor = .background
        layer.borderWidth = .zero
        font = .Body1_16
        textColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configure(placeholder: String) {
        placeholderLabel.text = placeholder
        placeholderLabel.font = .Body1_16
        placeholderLabel.textColor = .gray09
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Constant.padding8)
            make.left.equalToSuperview().inset(Constant.padding6)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textDidChange),
            name: UITextView.textDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func textDidChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
