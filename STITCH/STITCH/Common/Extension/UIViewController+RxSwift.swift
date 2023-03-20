//
//  UIViewController+RxSwift.swift
//  STITCH
//
//  Created by neuli on 2023/03/20.
//

import UIKit

import RxCocoa
import RxSwift

extension Reactive where Base: UIViewController {
    var viewWillAppear: ControlEvent<Bool> {
        let source = self.methodInvoked(#selector(Base.viewWillAppear(_:))).map { $0.first as? Bool ?? false }
        return ControlEvent(events: source)
    }
}
