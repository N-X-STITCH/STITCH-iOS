//
//  AuthCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol AuthCoordinatorDependencies {
    func nicknameViewController() -> NicknameViewController
    func profileViewController() -> ProfileViewController
}

final class AuthCoordinator: Coordinator {
    
    // MARK: - Properties
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    var disposeBag = DisposeBag()
    
    private let dependencies: AuthCoordinatorDependencies
    
    // MARK: - Initializer
    
    init(
        _ navigationController: UINavigationController,
        dependecies: AuthCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependecies
    }
    
    // MARK: - Methods
    
    func start() {
        showLoginViewController()
    }
    
    private func showLoginViewController() {
        // TODO: DIContainer
        let loginViewController = LoginViewController()
        addNextEvent(loginViewController, showNicknameViewController)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    private func showNicknameViewController() {
        let nicknameViewController = dependencies.nicknameViewController()
        addNextEvent(nicknameViewController, showProfileViewController)
        navigationController.pushViewController(nicknameViewController, animated: true)
    }
    
    private func showProfileViewController() {
        let profileViewController = dependencies.profileViewController()
        addNextEvent(profileViewController, showLocationViewController)
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    private func showLocationViewController() {
        let locationViewController = LocationViewController()
        locationViewController.coordinatorPublisher
            .subscribe { [weak self] event in
                if case .next = event {
                    self?.showInterestedInSportsViewController()
                }
                if case .findLocation = event {
                    self?.showFindLocationViewController()
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(locationViewController, animated: true)
    }
    
    private func showFindLocationViewController() {
        let findLocationViewController = FindLocationViewController()
        navigationController.pushViewController(findLocationViewController, animated: true)
    }
    
    private func showInterestedInSportsViewController() {
        let interestedInSportsViewController = InterestedInSportsViewController()
        addNextEvent(interestedInSportsViewController, showCompleteSignupViewController)
        navigationController.pushViewController(interestedInSportsViewController, animated: true)
    }
    
    private func showCompleteSignupViewController() {
        let completeSignupViewControoler = CompleteSignupViewController()
        
        navigationController.pushViewController(completeSignupViewControoler, animated: true)
    }
    
    private func addNextEvent(_ viewController: BaseViewController, _ showViewController: @escaping () -> Void) {
        viewController.coordinatorPublisher
            .subscribe { event in
                if case .next = event {
                    showViewController()
                }
            }
            .disposed(by: disposeBag)
    }
}
