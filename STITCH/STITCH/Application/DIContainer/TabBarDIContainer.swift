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
        let userDefaultsService: UserDefaultsService
        let naverCloudAPIService: URLSessionNetworkService
        let naverOpenAPIService: URLSessionNetworkService
        let appleIDService: URLSessionNetworkService
        let userUseCase: UserUseCase
    }
    
    // MARK: - Properties
    
    private let dependencies: Dependencies
    private let userUseCase: UserUseCase
    private var createMatchViewModel: CreateMatchViewModel!
    
    // MARK: - Initializer
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        self.userUseCase = dependencies.userUseCase
    }
    
    // MARK: - Coordinator
    
    func tabBarCoordinator(navigationController: UINavigationController) -> TabBarCoordinator {
        return TabBarCoordinator(navigationController, dependecies: self)
    }
    
    // MARK: - Repositories
    
    // MARK: Home
    
    func nearAddressRepository() -> NearAddressRepository {
        return DefaultNearAddressRepository(
            urlSessionNetworkService: dependencies.urlsessionNetworkService,
            naverCloudNetworkService: dependencies.naverCloudAPIService
        )
    }
    
    // MARK: User
    
    func userRepository() -> UserRepository {
        return DefaultUserRepository(urlSessionNetworkService: dependencies.urlsessionNetworkService)
    }
    
    func appleLoginRepository() -> AppleLoginRepository {
        return DefaultAppleLoginRepository(appleIDService: dependencies.appleIDService)
    }
    
    // MARK: Match
    
    func matchRepository() -> MatchRepository {
        return DefaultMatchRepository(urlSessionNetworkService: dependencies.urlsessionNetworkService)
    }
    
    // MARK: Storage
    
    func userStorage() -> UserStorage {
        return DefaultUserStorage(userDefaultsService: dependencies.userDefaultsService)
    }
    
    func fireStorageRepository() -> FireStorageRepository {
        return DefaultFireStorageRepository()
    }
    
    // MARK: Location
    
    func searchLocationRepository() -> SearchLocationRepository {
        return DefaultSearchLocationRepository(naverAPINetworkService: dependencies.naverOpenAPIService)
    }
    
    // MARK: - Use Cases
    
    // MARK: Auth
    
    func appleLoginUseCase() -> AppleLoginUseCase {
        return DefaultAppleLoginUseCase(appleLoginRepository: appleLoginRepository())
    }
    
    // MARK: Home
    
    func nearAddressUseCase() -> NearAddressUseCase {
        return DefaultNearAddressUseCase(nearAddressRepository: nearAddressRepository())
    }
    
    // MARK: Create Match
    
    func createMatchUseCase() -> CreateMatchUseCase {
        return DefaultCreateMatchUseCase(
            matchRepository: matchRepository(),
            fireStorageRepository: fireStorageRepository()
        )
    }
    
    func matchUseCase() -> MatchUseCase {
        return DefaultMatchUseCase(
            matchRepository: matchRepository(),
            userRepository: userRepository(),
            userStorage: userStorage()
        )
    }
    
    // MARK: Location
    
    func findLocationUseCase() -> FindLocationUseCase {
        return DefaultFindLocationUseCase(searchLocationRepository: searchLocationRepository())
    }
    
    // MARK: My Page
    
    func myPageUseCase() -> MyPageUseCase {
        return DefaultMyPageUseCase(
            userRepository: userRepository(),
            userStorage: userStorage(),
            fireStorageRepository: fireStorageRepository()
        )
    }
    
    // MARK: - View Models
    
    func homeViewModel() -> HomeViewModel {
        return HomeViewModel(
            userUseCase: userUseCase,
            myPageUseCase: myPageUseCase(),
            matchUseCase: matchUseCase()
        )
    }
    
    func findLocationViewModel() -> FindLocationViewModel {
        return FindLocationViewModel(nearAddressUseCase: nearAddressUseCase())
    }
    
    // MARK: Match
    
    func matchCategoryViewModel() -> MatchCategoryViewModel {
        return MatchCategoryViewModel(
            userUseCase: userUseCase,
            myPageUseCase: myPageUseCase(),
            matchUseCase: matchUseCase()
        )
    }
    
    func matchDetailViewModel() -> MatchDetailViewModel {
        return MatchDetailViewModel(
            userUseCase: userUseCase,
            matchUseCase: matchUseCase()
        )
    }
    
    // MARK: Create Match
    
    func makeCreateMatchViewModel() -> CreateMatchViewModel {
        return CreateMatchViewModel(
            createMatchUseCase: createMatchUseCase(),
            userUseCase: userUseCase
        )
    }
    
    // MARK: Location
    
    func setLocationViewModel() -> SetLocationViewModel {
        return SetLocationViewModel(findLocationUseCase: findLocationUseCase())
    }
    
    // MARK: My Match
    
    func myMatchViewModel() -> MyMatchViewModel {
        return MyMatchViewModel(
            userUseCase: userUseCase,
            myPageUseCase: myPageUseCase(),
            matchUseCase: matchUseCase()
        )
    }
    
    // MARK: My Page
    
    func myPageViewModel() -> MyPageViewModel {
        return MyPageViewModel(
            userUseCase: userUseCase,
            myPageUseCase: myPageUseCase()
        )
    }
    
    func myPageEditViewModel() -> MyPageEditViewModel {
        return MyPageEditViewModel(
            userUseCase: userUseCase,
            myPageUseCase: myPageUseCase()
        )
    }
    
    func createdMatchViewModel() -> CreatedMatchViewModel {
        return CreatedMatchViewModel()
    }
    
    func settingViewModel() -> SettingViewModel {
        return SettingViewModel(
            userUseCase: userUseCase,
            myPageUseCase: myPageUseCase(),
            appleLoginUseCase: appleLoginUseCase()
        )
    }
    
    // MARK: - ViewControllers
    
    func homeViewController() -> HomeViewController {
        return HomeViewController(homeViewModel: homeViewModel())
    }
    
    func findLocationViewController() -> FindLocationViewController {
        return FindLocationViewController(findLocationViewModel: findLocationViewModel())
    }
    
    
    // MARK: Match
    
    func matchCategoryViewController() -> MatchCategoryViewController {
        return MatchCategoryViewController(matchCategoryViewModel: matchCategoryViewModel())
    }
    
    func matchDetailViewController() -> MatchDetailViewController {
        return MatchDetailViewController(matchDetailViewModel: matchDetailViewModel())
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
    
    // MARK: Location
    
    func setLocationViewController() -> SetLocationViewController {
        return SetLocationViewController(
            createMatchViewModel: createMatchViewModel,
            setLocationViewModel: setLocationViewModel()
        )
    }
    
    // MARK: My Match
    
    func myMatchViewController() -> MyMatchViewController {
        return MyMatchViewController(myMatchViewModel: myMatchViewModel())
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
    
    func versionViewController() -> VersionViewController {
        return VersionViewController()
    }
}
