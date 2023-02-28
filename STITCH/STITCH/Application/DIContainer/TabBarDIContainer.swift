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
    
    // MARK: - Initializer
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    // MARK: - Coordinator
    
    func tabBarCoordinator(navigationController: UINavigationController) -> TabBarCoordinator {
        return TabBarCoordinator(navigationController, dependecies: self)
    }
    
    // MARK: - Repositories
    
    // MARK: - Use Cases
        
    // MARK: - View Models
    
    func homeViewModel() -> HomeViewModel {
        return HomeViewModel()
    }
    
    // MARK: - ViewControllers
    
    func homeViewController() -> HomeViewController {
        return HomeViewController(homeViewModel: homeViewModel())
    }
}
