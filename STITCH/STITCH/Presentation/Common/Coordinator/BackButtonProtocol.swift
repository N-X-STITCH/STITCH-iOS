//
//  BackButtonProtocol.swift
//  STITCH
//
//  Created by neuli on 2023/03/21.
//

import UIKit

import RxCocoa
import RxSwift

protocol BackButtonProtocol: BaseViewController {
    var backButton: UIButton! { get set }
    func addBackButtonTap()
}

extension BackButtonProtocol {
    func addBackButtonTap() {
        backButton = UIButton().then {
            $0.setImage(.arrowLeft, for: .normal)
        }
        backButton.rx.tap
            .asDriver()
            .drive { [weak self] _ in
                self?.coordinatorPublisher.onNext(.pop)
            }
            .disposed(by: disposeBag)
        
        let letftBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = letftBarButton
    }
}
