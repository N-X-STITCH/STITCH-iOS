//
//  LoginCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import Combine
import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    var cancelBag = Set<AnyCancellable>()
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginViewController()
    }
    
    func showLoginViewController() {
        // TODO: DIContainer
        let loginViewController = LoginViewController()
        loginViewController.coordinatorPublisher
            .sink { event in
                if case CoordinatorEvent.next = event {
                    
                }
            }
            .store(in: &cancelBag)
    }
}
