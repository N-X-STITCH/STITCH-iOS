//
//  LoginCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    
    // MARK: - Properties
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    
    func start() {
        showLoginViewController()
    }
    
    func showLoginViewController() {
        // TODO: DIContainer
        let loginViewController = LoginViewController()
        loginViewController.coordinatorPublisher
            .subscribe { event in
                return
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(loginViewController, animated: true)
    }
}
