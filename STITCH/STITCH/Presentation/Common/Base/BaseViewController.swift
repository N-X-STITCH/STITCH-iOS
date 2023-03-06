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
        configureNavigation()
        configureNavigationBar()
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
    func configureNavigation() {}
    func bind() {}
    func setting() {}
}

// MARK: - NavigationBar

extension BaseViewController {
    func configureNavigationBar(isTranslucent: Bool = true) {
        navigationController?.navigationBar.isTranslucent = isTranslucent
        if isTranslucent {
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            navigationController?.navigationBar.barTintColor = .background
        }
    }
}

// MARK: - Indicator

extension BaseViewController {
}

// MARK: - Gridient

extension BaseViewController {
}

// MARK: - Haptic

extension BaseViewController {
    func generateNotificationHaptic(_ feedBackType: UINotificationFeedbackGenerator.FeedbackType) {
        let hapticNotification = UINotificationFeedbackGenerator()
        hapticNotification.notificationOccurred(feedBackType)
    }
    
    func generateSelectionHaptic() {
        let haptic = UISelectionFeedbackGenerator()
        haptic.prepare()
        haptic.selectionChanged()
    }
    
    func generateImpactHaptic(_ feedBackType: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let haptic = UIImpactFeedbackGenerator(style: feedBackType)
        haptic.impactOccurred()
    }
}
