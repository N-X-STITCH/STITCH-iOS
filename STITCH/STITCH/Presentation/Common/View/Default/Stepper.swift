//
//  Stepper.swift
//  STITCH
//
//  Created by neuli on 2023/03/06.
//

import UIKit

import RxCocoa
import RxSwift

final class Stepper: UIControl {
    
    enum Constant {
        static let padding8 = 8
        static let iconWidth = 24
        static let labelWidth = 34
    }
    
    // MARK: - Properties
    
    private let minusButton = UIButton().then {
        let minusImage = UIImage.minusCircle?
            .withTintColor(.gray09, renderingMode: .alwaysOriginal)
        $0.setImage(minusImage, for: .normal)
    }
    
    private let countLabel = UILabel().then {
        $0.font = .Body1_16
        $0.textColor = .gray09
        $0.textAlignment = .center
    }
    
    private let plusButton = UIButton().then {
        let plusImage = UIImage.plusCircle?
            .withTintColor(.gray09, renderingMode: .alwaysOriginal)
        $0.setImage(plusImage, for: .normal)
    }
    
    var value: Int = 0 {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(
        defaultText: String,
        defaultValue: Int
    ) {
        super.init(frame: .zero)
        countLabel.text = defaultText
        value = defaultValue
        plusButton.tag = defaultValue
        minusButton.tag = -defaultValue
        
        configureUI()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func configureUI() {
        addSubviews([minusButton, countLabel, plusButton])
        
        countLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(Constant.labelWidth)
            make.height.equalTo(Constant.iconWidth)
        }
        
        minusButton.snp.makeConstraints { make in
            make.right.equalTo(countLabel.snp.left).offset(-Constant.padding8)
            make.centerY.equalTo(countLabel)
        }
        
        plusButton.snp.makeConstraints { make in
            make.left.equalTo(countLabel.snp.right).offset(Constant.padding8)
            make.centerY.equalTo(countLabel)
        }
    }
    
    private func setupBindings() {
        plusButton.addTarget(self, action: #selector(valueChanged(_:)), for: .touchUpInside)
        
        let valueObservable = rx.controlEvent(.valueChanged)
            .map { [unowned self] in self.value }
        
        valueObservable
            .bind(to: rx.value)
            .disposed(by: disposeBag)
    }
    
    @objc func valueChanged(_ sender: UIButton) {
        value += sender.tag
    }
}

extension Reactive where Base: Stepper {
    var value: Observable<Int> {
        return base.rx.controlEvent(.valueChanged).map { self.base.value }
    }
}
