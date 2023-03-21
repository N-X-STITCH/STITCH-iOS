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
        let loginViewController = dependencies.loginViewController()
        let coordinatorPublisher = loginViewController.coordinatorPublisher.share()
        
        addEvent(coordinatorPublisher, showInterestedInSportsViewController, .next)
        addEvent(coordinatorPublisher, finish, .showHome)
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    private func showInterestedInSportsViewController() {
        let interestedInSportsViewController = dependencies.interestedInSportsViewController()
        let coordinatorPublisher = interestedInSportsViewController.coordinatorPublisher.share()
        
        addEvent(coordinatorPublisher, showLocationViewController, .next)
        addPopEvent(coordinatorPublisher)
        navigationController.pushViewController(interestedInSportsViewController, animated: true)
    }
    
    private func showLocationViewController() {
        let locationViewController = dependencies.locationViewController()
        let coordinatorPublisher = locationViewController.coordinatorPublisher.share()
        
        addEvent(coordinatorPublisher, showCompleteSignupViewController, .next)
        addPopEvent(coordinatorPublisher)
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .next)
            .withUnretained(self)
            .emit { owner, event in
                if case .findLocation = event {
                    owner.showFindLocationViewController(locationViewController: locationViewController)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(locationViewController, animated: true)
    }
    
    private func showFindLocationViewController(locationViewController: LocationViewController) {
        let findLocationViewController = dependencies.findLocationViewController()
        let coordinatorPublisher = findLocationViewController.coordinatorPublisher.share()
        
        addPopEvent(coordinatorPublisher)
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .withUnretained(self)
            .emit() { owner, event in
                if case .send(let locationInfo) = event {
                    locationViewController.didReceive(locationInfo: locationInfo)
                    owner.popViewController()
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(findLocationViewController, animated: true)
    }
    
    private func showCompleteSignupViewController() {
        let completeSignupViewController = dependencies.completeSignupViewController()
        let coordinatorPublisher = completeSignupViewController.coordinatorPublisher.share()
        
        addEvent(coordinatorPublisher, finish, .next)
        addPopEvent(coordinatorPublisher)
        navigationController.pushViewController(completeSignupViewController, animated: true)
    }
}
