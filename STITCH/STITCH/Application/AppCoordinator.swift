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
    private let userUseCase: UserUseCase
    
    // MARK: - Initializer
    
    init(
        _ navigationController: UINavigationController,
        appDIContainer: AppDIContainer
    ) {
        self.navigationController = navigationController
        self.appDIContainer = appDIContainer
        self.userUseCase = appDIContainer.userUseCase
        childCoordinators = []
    }
    
    // MARK: - Methods
    
    func start() {
        userUseCase.savedUser()
            .take(1)
            .subscribe (onNext: { user in
                if let _ = user {
                    self.showTabFlow()
                } else {
                    self.showAuthFlow()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showAuthFlow() {
        let authDIContainer = appDIContainer.makeAuthSceneDIContainer()
        let authCoordinator = authDIContainer.authCoordinator(navigationController: navigationController)
        authCoordinator.finishDelegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }
    
    func showTabFlow() {
        let tabBarDIContainer = appDIContainer.makeTabBarDIContainer()
        let tabBarCoordinator = tabBarDIContainer.tabBarCoordinator(navigationController: navigationController)
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
