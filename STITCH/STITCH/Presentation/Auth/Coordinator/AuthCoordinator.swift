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
    func locationViewController() -> LocationViewController
    func findLocationViewController() -> FindLocationViewController
    func interestedInSportsViewController() -> InterestedInSportsViewController
    func completeSignupViewController() -> CompleteSignupViewController
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
        navigationController.pushViewController(loginViewController, animated: false)
    }
    
    private func showNicknameViewController() {
        let nicknameViewController = dependencies.nicknameViewController()
        addNextEvent(nicknameViewController, showProfileViewController)
        navigationController.pushViewController(nicknameViewController, animated: false)
    }
    
    private func showProfileViewController() {
        let profileViewController = dependencies.profileViewController()
        addNextEvent(profileViewController, showLocationViewController)
        navigationController.pushViewController(profileViewController, animated: false)
    }
    
    private func showLocationViewController() {
        let locationViewController = dependencies.locationViewController()
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
        navigationController.pushViewController(locationViewController, animated: false)
    }
    
    private func showFindLocationViewController() {
        let findLocationViewController = dependencies.findLocationViewController()
        navigationController.pushViewController(findLocationViewController, animated: true)
    }
    
    private func showInterestedInSportsViewController() {
        let interestedInSportsViewController = dependencies.interestedInSportsViewController()
        addNextEvent(interestedInSportsViewController, showCompleteSignupViewController)
        navigationController.pushViewController(interestedInSportsViewController, animated: false)
    }
    
    private func showCompleteSignupViewController() {
        let completeSignupViewControoler = dependencies.completeSignupViewController()
        
        navigationController.pushViewController(completeSignupViewControoler, animated: false)
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
