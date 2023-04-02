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
    func findLocationViewController() -> FindLocationViewController
    // Category
    func matchCategoryViewController() -> MatchCategoryViewController
    func matchDetailViewController() -> MatchDetailViewController
    // Create Match
    func selectMatchViewController() -> SelectMatchViewController
    func selectSportViewController() -> SelectSportViewController
    func createMatchViewController() -> CreateMatchViewController
    func setLocationViewController() -> SetLocationViewController
    // My Match
    func myMatchViewController() -> MyMatchViewController
    // My Page
    func myPageViewController() -> MyPageViewController
    func myPageEditViewController() -> MyPageEditViewController
    func createdMatchViewController() -> CreatedMatchViewController
    func settingViewController() -> SettingViewController
    func versionViewController() -> VersionViewController
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
            showMyMatchViewController(navigationController)
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
        let coordinatorPublisher = homeViewController.coordinatorPublisher.share()
        
        addEventWithNav(coordinatorPublisher, showSelectMatchViewController(_:), navigationController, .selectMatchType)
        coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .findLocation = event {
                    owner.showFindLocationViewController(navigationController, homeViewController)
                } else if case .created(let match) = event {
                    owner.showMatchDetailViewController(navigationController, match: match)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    private func showSelectMatchViewController(_ navigationController: UINavigationController) {
        let selectMatchViewController = dependencies.selectMatchViewController()
        selectMatchViewController.hidesBottomBarWhenPushed = true
        let coordinatorPublisher = selectMatchViewController.coordinatorPublisher.share()
        
        addEventWithNav(coordinatorPublisher, showSelectSportViewController(_:), navigationController, .next)
        addPopEvent(coordinatorPublisher, navigationController)
        navigationController.pushViewController(selectMatchViewController, animated: true)
    }
    
    private func showSelectSportViewController(_ navigationController: UINavigationController) {
        let selectSportViewController = dependencies.selectSportViewController()
        let coordinatorPublisher = selectSportViewController.coordinatorPublisher.share()
        
        addEventWithNav(coordinatorPublisher, showCreateMatchViewController(_:), navigationController, .next)
        addPopEvent(coordinatorPublisher, navigationController)
        navigationController.pushViewController(selectSportViewController, animated: true)
    }
    
    private func showFindLocationViewController(
        _ navigationController: UINavigationController,
        _ homeViewController: HomeViewController? = nil,
        _ matchCategoryViewController: MatchCategoryViewController? = nil
    ) {
        let findLocationViewController = dependencies.findLocationViewController()
        findLocationViewController.hidesBottomBarWhenPushed = true
        let coordinatorPublisher = findLocationViewController.coordinatorPublisher
        
        addPopEvent(coordinatorPublisher, navigationController)
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .withUnretained(self)
            .emit() { owner, event in
                if case .send(let locationInfo) = event {
                    if let homeViewController {
                        homeViewController.didReceive(locationInfo: locationInfo)
                    } else if let matchCategoryViewController {
                        matchCategoryViewController.didReceive(locationInfo: locationInfo)
                    }
                    navigationController.popViewController(animated: true)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(findLocationViewController, animated: true)
    }
}

// MARK: - Match Category

extension TabBarCoordinator {
    private func showMatchCategoryViewController(_ navigationController: UINavigationController) {
        let matchCategoryViewController = dependencies.matchCategoryViewController()
        let coordinatorPublisher = matchCategoryViewController.coordinatorPublisher.share()
        
        addEventWithNav(coordinatorPublisher, showSelectMatchViewController(_:), navigationController, .selectMatchType)
        coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .findLocation = event {
                    owner.showFindLocationViewController(navigationController, nil, matchCategoryViewController)
                } else if case .created(let match) = event {
                    owner.showMatchDetailViewController(navigationController, match: match)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(matchCategoryViewController, animated: true)
    }
}

// MARK: - Match
extension TabBarCoordinator {
    private func showMatchDetailViewController(_ navigationController: UINavigationController, match: Match) {
        let matchDetailViewController = dependencies.matchDetailViewController()
        matchDetailViewController.hidesBottomBarWhenPushed = true
        matchDetailViewController.matchObservable.onNext(match)
        let coordinatorPublisher = matchDetailViewController.coordinatorPublisher.share()
        
        addPopEvent(coordinatorPublisher, navigationController)
        matchDetailViewController.coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .withUnretained(self)
            .emit { owner, event in
                if case .block = event {
                    navigationController.popViewController(animated: true)
                    owner.showAlert(message: "해당 글이 차단되었습니다.")
                } else if case .report = event {
                    navigationController.popViewController(animated: true)
                    owner.showAlert(message: "해당 글이 신고되었습니다. 24시간 이내에 처리될 예정입니다.")
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(matchDetailViewController, animated: true)
    }
}


// MARK: - Create Match

extension TabBarCoordinator {
    private func showCreateMatchViewController(_ navigationController: UINavigationController) {
        let createMatchViewController = dependencies.createMatchViewController()
        let coordinatorPublisher = createMatchViewController.coordinatorPublisher.share()
        
        addPopEvent(coordinatorPublisher, navigationController)
        coordinatorPublisher
            .asSignal(onErrorJustReturn: .pop)
            .withUnretained(self)
            .emit() { owner, event in
                if case .setLocation = event {
                    owner.showSetLocationViewController(navigationController, createMatchViewController)
                } else if case .created(let match) = event {
                    navigationController.popToRootViewController(animated: true)
                    owner.showMatchDetailViewController(navigationController, match: match)
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
        let coordinatorPublisher = setLocationViewController.coordinatorPublisher.share()
        addPopEvent(coordinatorPublisher, navigationController)
        coordinatorPublisher
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

// MARK: - My Match

extension TabBarCoordinator {
    private func showMyMatchViewController(_ navigationController: UINavigationController) {
        let myMatchViewController = dependencies.myMatchViewController()
        let coordinatorPublisher = myMatchViewController.coordinatorPublisher.share()
        
        coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .created(let match) = event {
                    owner.showMatchDetailViewController(navigationController, match: match)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(myMatchViewController, animated: true)
    }
}

// MARK: - MyPage

extension TabBarCoordinator {
    private func showMyPageViewController(_ navigationController: UINavigationController) {
        let myPageViewController = dependencies.myPageViewController()
        let coordinatorPublisher = myPageViewController.coordinatorPublisher.share()
        
        addEventWithNav(coordinatorPublisher, showMyPageEditViewController(_:), navigationController, .next)
        addEventWithNav(coordinatorPublisher, showSettingViewController(_:), navigationController, .setting)
        coordinatorPublisher
            .withUnretained(self)
            .subscribe { owner, event in
                if case .created(let match) = event {
                    owner.showMatchDetailViewController(navigationController, match: match)
                }
            }
            .disposed(by: disposeBag)
        navigationController.pushViewController(myPageViewController, animated: true)
    }
    
    private func showMyPageEditViewController(_ navigationController: UINavigationController) {
        let myPageEditViewController = dependencies.myPageEditViewController()
        let coordinatorPublisher = myPageEditViewController.coordinatorPublisher.share()
        
        addDismissEvent(coordinatorPublisher)
        myPageEditViewController.modalPresentationStyle = .fullScreen
        navigationController.present(myPageEditViewController, animated: true)
    }
    
    private func showSettingViewController(_ navigationController: UINavigationController) {
        let settingViewController = dependencies.settingViewController()
        let coordinatorPublisher = settingViewController.coordinatorPublisher.share()
        
        addEvent(coordinatorPublisher, finish, .showLogin)
        addEventWithNav(coordinatorPublisher, showVersionViewController(_:), navigationController, .version)
        addPopEvent(coordinatorPublisher, navigationController)
        navigationController.pushViewController(settingViewController, animated: true)
    }
    
    private func showVersionViewController(_ navigationController: UINavigationController) {
        let versionViewController = dependencies.versionViewController()
        let coordinatorPublisher = versionViewController.coordinatorPublisher.share()
        
        addPopEvent(coordinatorPublisher, navigationController)
        navigationController.pushViewController(versionViewController, animated: true)
    }
}
