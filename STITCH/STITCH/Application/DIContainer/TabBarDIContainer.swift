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
    private lazy var createMatchViewModel = CreateMatchViewModel(createMatchUseCase: createMatchUseCase())
    
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
    
    // MARK: Create Match
    
    // MARK: - ViewControllers
    
    func homeViewController() -> HomeViewController {
        return HomeViewController(homeViewModel: homeViewModel())
    }
    
    // MARK: Create Match
    
    func selectMatchViewController() -> SelectMatchViewController {
        return SelectMatchViewController(createMatchViewModel: createMatchViewModel)
    }
}
