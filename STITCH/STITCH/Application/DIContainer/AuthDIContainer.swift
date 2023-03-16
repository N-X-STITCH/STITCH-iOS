//
//  AuthDIContainer.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import UIKit

final class AuthDIContainer {
    
    struct Dependencies {
        let urlsessionNetworkService: URLSessionNetworkService
        let naverCloudAPIService: URLSessionNetworkService
        let userDefaultsService: UserDefaultsService
        let userUseCase: UserUseCase
    }
    
    // MARK: - Properties
    
    private let dependencies: Dependencies
    private let userUseCase: UserUseCase
    
    private lazy var signupViewModel = SignupViewModel(
        signupUseCase: signupUseCase(),
        userUseCase: userUseCase
    )
    
    // MARK: - Initializer
    
    init(
        dependencies: Dependencies
    ) {
        self.dependencies = dependencies
        self.userUseCase = dependencies.userUseCase
    }
    
    // MARK: - Coordinator
    
    func authCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        return AuthCoordinator(navigationController, dependecies: self)
    }
    
    // MARK: - Repositories
    
    // MARK: Auth
    
    func signupRepository() -> SignupRepository {
        return DefaultSignupRepository(urlSessionNetworkService: dependencies.urlsessionNetworkService)
    }
    
    // MARK: Location
    
    func nearAddressesRepository() -> NearAddressRepository {
        return DefaultNearAddressRepository(
            urlSessionNetworkService: dependencies.urlsessionNetworkService,
            naverCloudNetworkService: dependencies.naverCloudAPIService
        )
    }
    
    // MARK: - Use Cases
    
    // MARK: Auth
    
    func signupUseCase() -> SignupUseCase {
        return DefaultSignupUseCase(signupRepository: signupRepository())
    }
    
    func nicknameUseCase() -> NicknameUseCase {
        return DefaultNicknameUseCase()
    }
    
    // MARK: Location
    
    func findLocationUseCase() -> FindLocationUseCase {
        return DefaultFindLocationUseCase()
    }
    
    func nearAddressesUseCase() -> NearAddressUseCase {
        return DefaultNearAddressUseCase(nearAddressRepository: nearAddressesRepository())
    }
    
    // MARK: - View Models
    
    func loginViewModel() -> LoginViewModel {
        return LoginViewModel(signupUseCase: signupUseCase())
    }
    
    func findLocationViewModel() -> FindLocationViewModel {
        return FindLocationViewModel(nearAddressUseCase: nearAddressesUseCase())
    }
    
    func interestedInSportsViewModel() -> InterestedSportsViewModel {
        return InterestedSportsViewModel()
    }
    
    // MARK: - ViewControllers
    
    func loginViewController() -> LoginViewController {
        return LoginViewController(
            loginViewModel: loginViewModel(),
            signupViewModel: signupViewModel
        )
    }
    
    func locationViewController() -> LocationViewController {
        return LocationViewController(signupViewModel: signupViewModel)
    }
    
    func findLocationViewController() -> FindLocationViewController {
        return FindLocationViewController(findLocationViewModel: findLocationViewModel())
    }
    
    func interestedInSportsViewController() -> InterestedInSportsViewController {
        return InterestedInSportsViewController(
            interestedInSportsViewModel: interestedInSportsViewModel(),
            signupViewModel: signupViewModel
        )
    }
    
    func completeSignupViewController() -> CompleteSignupViewController {
        return CompleteSignupViewController(signupViewModel: signupViewModel)
    }
}

extension AuthDIContainer: AuthCoordinatorDependencies {}
