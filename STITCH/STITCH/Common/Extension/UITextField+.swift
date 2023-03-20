//
//  UITextField+.swift
//  STITCH
//
//  Created by neuli on 2023/03/16.
//

import UIKit

import RxSwift

extension UITextField {
    func editingDidBegin(rowView: UIView) -> Disposable {
        rx.controlEvent(.editingDidBegin)
            .subscribe { _ in
                rowView.updateBackgroundColor(isEditing: true)
            }
    }
    
    func editingDidEnd(rowView: UIView) -> Disposable {
        rx.controlEvent(.editingDidEnd)
            .subscribe { _ in
                rowView.updateBackgroundColor(isEditing: false)
            }
    }
}

