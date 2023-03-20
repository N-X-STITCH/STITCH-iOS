//
//  UITextView+.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import UIKit

import RxSwift

extension UITextView {
    func editingDidBegin(rowView: UIView) -> Disposable {
        rx.didBeginEditing
            .subscribe { _ in
                rowView.updateBackgroundColor(isEditing: true)
            }
    }
    
    func editingDidEnd(rowView: UIView) -> Disposable {
        rx.didEndEditing
            .subscribe { _ in
                rowView.updateBackgroundColor(isEditing: false)
            }
    }
}
