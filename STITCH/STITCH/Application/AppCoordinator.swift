//
//  AppCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol AppCoordinatorProtocol: Coordinator {
    func showAuthFlow()
    func showTabFlow()
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    // MARK: - Properties
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    var type: CoordinatorType { .app }
    var disposeBag = DisposeBag()
    
    private let appDIContainer: AppDIContainer
    
    // MARK: - Initializer
    
    init(
        _ navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        childCoordinators = []
    }
    
    // MARK: - Methods
    
    func start() {
        // TODO: Login 분기처리 (자동로그인)
        showAuthFlow()
    }
    
    func showAuthFlow() {
        let authDIContainer = appDIContainer.makeAuthSceneDIContainer()
        let authCoordinator = authDIContainer.authCoordinator(navigationController: navigationController)
        authCoordinator.finishDelegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
    
    func showTabFlow() {
        let tabBarCoordinator = TabBarCoordinator(navigationController)
        tabBarCoordinator.finishDelegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        
        switch childCoordinator.type {
        case .login:
            navigationController.viewControllers.removeAll()
            showTabFlow()
        case .tab:
            navigationController.viewControllers.removeAll()
            showAuthFlow()
        default:
            break
        }
    }
}
