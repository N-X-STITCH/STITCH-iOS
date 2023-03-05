//
//  TabBarCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol TabBarCoordinatorDependencies {
    func homeViewController() -> HomeViewController
}

final class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .tab }
    var disposeBag = DisposeBag()
    var tabBarController: UITabBarController
    
    private let dependencies: TabBarCoordinatorDependencies
    
    // MARK: - Initializer
    
    init(
        _ navigationController: UINavigationController,
        dependecies: TabBarCoordinatorDependencies
    ) {
        self.navigationController = navigationController
        self.dependencies = dependecies
        tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .yellow05_primary
    }
    
    // MARK: - Methods
    
    func start() {
        navigationController.isNavigationBarHidden = true
        // TODO: 탭바 추가
        let pages: [TabBarPage] = [.home, .category, .myMatch, .myMenu]
        let controllers: [UINavigationController] = pages.map { tabController($0) }
        prepareTabBarController(with: controllers)
    }
    
    
}

extension TabBarCoordinator {
    private func prepareTabBarController(with tabControllers: [UIViewController]) {
        // tabBarController.delegate = self
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.selectedIndex = TabBarPage.home.pageNumber
        configureTabBar(with: tabControllers)
        navigationController.viewControllers = [tabBarController]
    }
    
    private func tabController(_ page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(
            title: page.title,
            image: page.deselectedIcon,
            selectedImage: page.selectedIcon
        )
        
        switch page {
        case .home:
            let homeViewController = dependencies.homeViewController()
            navigationController.pushViewController(homeViewController, animated: true)
        case .category:
            navigationController.pushViewController(UIViewController(), animated: true)
        case .myMatch:
            navigationController.pushViewController(UIViewController(), animated: true)
        case .myMenu:
            // let ProfileViewController = ProfileViewController()
            navigationController.pushViewController(UIViewController(), animated: true)
        }
        return navigationController
    }
    
    private func configureTabBar(with tabControllers: [UIViewController]) {
        tabBarController.tabBar.backgroundColor = .background
        tabBarController.tabBar.isTranslucent = false
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            tabBarAppearance.backgroundColor = .background
            tabBarController.tabBar.standardAppearance = tabBarAppearance
        }
    }
}
