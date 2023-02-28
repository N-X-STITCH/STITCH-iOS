//
//  AuthCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol AuthCoordinatorDependencies {
    func loginViewController() -> LoginViewController
    func interestedInSportsViewController() -> InterestedInSportsViewController
    func locationViewController() -> LocationViewController
    func findLocationViewController() -> FindLocationViewController
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
        let loginViewController = dependencies.loginViewController()
        addNextEvent(loginViewController, showInterestedInSportsViewController)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    private func showInterestedInSportsViewController() {
        let interestedInSportsViewController = dependencies.interestedInSportsViewController()
        addNextEvent(interestedInSportsViewController, showLocationViewController)
        navigationController.pushViewController(interestedInSportsViewController, animated: true)
    }
    
    private func showLocationViewController() {
        let locationViewController = dependencies.locationViewController()
        locationViewController.coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .next = event {
                    owner.showCompleteSignupViewController()
                }
                if case .findLocation = event {
                    owner.showFindLocationViewController()
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(locationViewController, animated: true)
    }
    
    private func showFindLocationViewController() {
        let findLocationViewController = dependencies.findLocationViewController()
        navigationController.pushViewController(findLocationViewController, animated: true)
    }
    
    private func showCompleteSignupViewController() {
        let completeSignupViewController = dependencies.completeSignupViewController()
        completeSignupViewController.coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .next = event {
                    owner.finish()
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(completeSignupViewController, animated: true)
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
