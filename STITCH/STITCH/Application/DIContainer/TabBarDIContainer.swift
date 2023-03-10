//
//  TabBarDIContainer.swift
//  STITCH
//
//  Created by neuli on 2023/02/28.
//

import UIKit

final class TabBarDIContainer: TabBarCoordinatorDependencies {
    
    struct Dependencies {
        let urlsessionNetworkService: URLSessionNetworkService
    }
    
    // MARK: - Properties
    
    private let dependencies: Dependencies
    private var createMatchViewModel: CreateMatchViewModel!
    
    // MARK: - Initializer
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Coordinator
    
    func tabBarCoordinator(navigationController: UINavigationController) -> TabBarCoordinator {
        return TabBarCoordinator(navigationController, dependecies: self)
    }
    
    // MARK: - Repositories
    
    func matchRepository() -> MatchRepository {
        return DefaultMatchRepository(urlSessionNetworkService: dependencies.urlsessionNetworkService)
    }
    
    // MARK: - Use Cases
    
    func createMatchUseCase() -> CreateMatchUseCase {
        return DefaultCreateMatchUseCase(matchRepository: matchRepository())
    }
        
    // MARK: - View Models
    
    func homeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
    func makeCreateMatchViewModel() -> CreateMatchViewModel {
        return CreateMatchViewModel(createMatchUseCase: createMatchUseCase())
    }
    
    // MARK: Create Match
    
    // MARK: My Page
    
    func myPageViewModel() -> MyPageViewModel {
        return MyPageViewModel()
    }
    
    func myPageEditViewModel() -> MyPageEditViewModel {
        return MyPageEditViewModel()
    }
    
    func createdMatchViewModel() -> CreatedMatchViewModel {
        return CreatedMatchViewModel()
    }
    
    func settingViewModel() -> SettingViewModel {
        return SettingViewModel()
    }
    
    // MARK: - ViewControllers
    
    func homeViewController() -> HomeViewController {
        return HomeViewController(homeViewModel: homeViewModel())
    }
    
    // MARK: Create Match
    
    func selectMatchViewController() -> SelectMatchViewController {
        createMatchViewModel = makeCreateMatchViewModel()
        return SelectMatchViewController(createMatchViewModel: createMatchViewModel)
    }
    
    func selectSportViewController() -> SelectSportViewController {
        return SelectSportViewController(createMatchViewModel: createMatchViewModel)
    }
    
    func createMatchViewController() -> CreateMatchViewController {
        return CreateMatchViewController(createMatchViewModel: createMatchViewModel)
    }
    
    // MARK: My Page
    
    func myPageViewController() -> MyPageViewController {
        return MyPageViewController(myPageViewModel: myPageViewModel())
    }
    
    func myPageEditViewController() -> MyPageEditViewController {
        return MyPageEditViewController(myPageEditViewModel: myPageEditViewModel())
    }
    
    func createdMatchViewController() -> CreatedMatchViewController {
        return CreatedMatchViewController(createdMatchViewModel: createdMatchViewModel())
    }
    
    func settingViewController() -> SettingViewController {
        return SettingViewController(settingViewModel: settingViewModel())
    }
}
