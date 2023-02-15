//
//  BaseViewController.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Combine
import UIKit

import SnapKit
import Then

class BaseViewController: UIViewController {
    
    // MARK: - Properties
    
    var coordinatorPublisher = PassthroughSubject<CoordinatorEvent, Never>()
    var cancelBag = Set<AnyCancellable>()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    func bind() {}
}

// MARK: - NavigationBar

extension BaseViewController {
}

// MARK: - Indicator

extension BaseViewController {
}
