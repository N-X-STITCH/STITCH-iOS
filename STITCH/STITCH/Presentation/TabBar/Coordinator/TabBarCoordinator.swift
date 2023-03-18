//
//  TabBarCoordinator.swift
//  STITCH
//
//  Created by neuli on 2023/02/15.
//

import UIKit

import RxSwift

protocol TabBarCoordinatorDependencies {
    // Home
    func homeViewController() -> HomeViewController
    // Category
    func matchCategoryViewController() -> MatchCategoryViewController
    // Create Match
    func selectMatchViewController() -> SelectMatchViewController
    func selectSportViewController() -> SelectSportViewController
    func createMatchViewController() -> CreateMatchViewController
    func setLocationViewController() -> SetLocationViewController
    // My Page
    func myPageViewController() -> MyPageViewController
    func myPageEditViewController() -> MyPageEditViewController
    func createdMatchViewController() -> CreatedMatchViewController
    func settingViewController() -> SettingViewController
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
            showHomeViewController(navigationController)
        case .category:
            showMatchCategoryViewController(navigationController)
        case .myMatch:
            navigationController.pushViewController(UIViewController(), animated: true)
        case .myMenu:
            showMyPageViewController(navigationController)
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

// MARK: - Home

extension TabBarCoordinator {
    private func showHomeViewController(_ navigationController: UINavigationController) {
        let homeViewController = dependencies.homeViewController()
        homeViewController.coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .selectMatchType = event {
                    owner.showSelectMatchViewController(navigationController)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    private func showSelectMatchViewController(_ navigationController: UINavigationController) {
        let selectMatchViewController = dependencies.selectMatchViewController()
        selectMatchViewController.hidesBottomBarWhenPushed = true
        addNextEventWithNav(
            selectMatchViewController,
            showSelectSportViewController(_:),
            navigationController
        )
        navigationController.pushViewController(selectMatchViewController, animated: true)
    }
    
    private func showSelectSportViewController(_ navigationController: UINavigationController) {
        let selectSportViewController = dependencies.selectSportViewController()
        addNextEventWithNav(
            selectSportViewController,
            showCreateMatchViewController(_:),
            navigationController
        )
        navigationController.pushViewController(selectSportViewController, animated: true)
    }
}

// MARK: - Match Category

extension TabBarCoordinator {
    private func showMatchCategoryViewController(_ navigationController: UINavigationController) {
        let matchCategoryViewController = dependencies.matchCategoryViewController()
        matchCategoryViewController.coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .selectMatchType = event {
                    owner.showSelectMatchViewController(navigationController)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(matchCategoryViewController, animated: true)
    }
}

// MARK: - Create Match

extension TabBarCoordinator {
    private func showCreateMatchViewController(_ navigationController: UINavigationController) {
        let createMatchViewController = dependencies.createMatchViewController()
        createMatchViewController.coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .withUnretained(self)
            .emit() { owner, event in
                if case .setLocation = event {
                    owner.showSetLocationViewController(navigationController, createMatchViewController)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(createMatchViewController, animated: true)
    }
    
    private func showSetLocationViewController(
        _ navigationController: UINavigationController,
        _ createMatchViewController: CreateMatchViewController
    ) {
        let setLocationViewController = dependencies.setLocationViewController()
        setLocationViewController.coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .withUnretained(self)
            .emit() { owner, event in
                if case .send(let locationInfo) = event {
                    createMatchViewController.didReceive(locationInfo: locationInfo)
                    navigationController.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(setLocationViewController, animated: true)
    }
}

// MARK: - MyPage

extension TabBarCoordinator {
    private func showMyPageViewController(_ navigationController: UINavigationController) {
        let myPageViewController = dependencies.myPageViewController()
        myPageViewController.coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .next = event {
                    owner.showMyPageEditViewController(navigationController)
                } else if case .setting = event {
                    owner.showSettingViewController(navigationController)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(myPageViewController, animated: true)
    }
    
    private func showMyPageEditViewController(_ navigationController: UINavigationController) {
        let myPageEditViewController = dependencies.myPageEditViewController()
        addDismissEvent(myPageEditViewController)
        myPageEditViewController.modalPresentationStyle = .fullScreen
        navigationController.present(myPageEditViewController, animated: true)
    }
    
    private func showSettingViewController(_ navigationController: UINavigationController) {
        let settingViewController = dependencies.settingViewController()
        navigationController.pushViewController(settingViewController, animated: true)
    }
}
