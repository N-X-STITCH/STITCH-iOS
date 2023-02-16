//
//  TabBarCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
}

final class TabBarCoordinator: TabBarCoordinatorProtocol {
    
    // MARK: - Properties
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .tab }
    var disposeBag = DisposeBag()
    var tabBarController: UITabBarController
    
    // MARK: - Initializer
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        tabBarController = UITabBarController()
    }
    
    // MARK: - Methods
    
    func start() {
        // TODO: 탭바 추가
        let pages: [TabBarPage] = [.home, .profile]
        let controllers: [UINavigationController] = pages.map { tabController($0) }
        prepareTabBarController(with: controllers)
    }
    
    
}

extension TabBarCoordinator {
    private func prepareTabBarController(with tabController: [UIViewController]) {
        // tabBarController.delegate = self
        tabBarController.setViewControllers(tabController, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageNumber
        
        navigationController.viewControllers = [tabBarController]
    }
    
    private func tabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: page.title,
            image: nil,
            selectedImage: nil
        )
        
        switch page {
        case .home:
            // let homeViewController = HomeViewController()
            navigationController.pushViewController(UIViewController(), animated: true)
        case .profile:
            // let ProfileViewController = ProfileViewController()
            navigationController.pushViewController(UIViewController(), animated: true)
        }
        return navigationController
    }
}
