//
//  BaseViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift
import SnapKit
import Then

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var coordinatorPublisher = PublishSubject<CoordinatorEvent>()
    var disposeBag = DisposeBag()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
        setting()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    func bind() {}
    func setting() {}
}

// MARK: - NavigationBar

extension BaseViewController {
}

// MARK: - Indicator

extension BaseViewController {
}

// MARK: - Gridient

extension BaseViewController {
}
