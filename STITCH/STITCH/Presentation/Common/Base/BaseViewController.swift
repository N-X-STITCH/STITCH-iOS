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
        setting()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        configureNavigation()
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

// MARK: - Keyboard

extension BaseViewController {
    func hideKeyboard() {
        view.endEditing(true)
    }
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

// MARK: - ToastMessage

extension BaseViewController {
    func showToastMessage(
        text: String,
        tintColor: UIColor? = .gray04,
        icon: UIImage?
    ) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let toastMessage = self.toastMessageView(text: text, tintColor: tintColor, icon: icon)
            self.view.addSubview(toastMessage)
            toastMessage.snp.makeConstraints { make in
                make.left.right.equalToSuperview().inset(16)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).inset(16)
                make.height.equalTo(48)
            }
            
            UIView.animate(withDuration: 2.0, delay: 1.0, options: [.curveEaseOut]) {
                toastMessage.alpha = 0.0
            } completion: { _ in
                toastMessage.removeFromSuperview()
            }
        }
    }
    
    private func toastMessageView(
        text: String,
        tintColor: UIColor? = .gray04,
        icon: UIImage?
    ) -> UIView {
        let toastMessageView = UIView().then {
            $0.backgroundColor = .gray12
        }
        let iconImageView = UIImageView(image: icon)
        let messageLabel = UILabel().then {
            $0.text = text
            $0.textColor = tintColor
            $0.font = .Body2_14
        }
        toastMessageView.addSubviews([iconImageView, messageLabel])
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
        }
        
        return toastMessageView
    }
}

// MARK: - UIResponder + handle error

extension UIResponder {
    func handle(error: Error) {
        guard let viewController = self as? BaseViewController else {
            guard let nextReponder = next else {
                return assertionFailure("처리할 수 없는 에러 \(error.localizedDescription)")
            }
            nextReponder.handle(error: error)
            return
        }
        
        viewController.showToastMessage(
            text: "\(error.localizedDescription)",
            icon: UIImage(systemName: "xmark.circle.fill")?.withTintColor(.gray04, renderingMode: .alwaysOriginal)
        )
    }
}
