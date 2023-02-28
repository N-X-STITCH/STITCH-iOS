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
    }
    
    // MARK: - Properties
    
    private let dependencies: Dependencies
    private let signupViewModel: SignupViewModel
    
    // MARK: - Initializer
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
        signupViewModel = SignupViewModel()
    }
    
    // MARK: - Coordinator
    
    func authCoordinator(navigationController: UINavigationController) -> AuthCoordinator {
        return AuthCoordinator(navigationController, dependecies: self)
    }
    
    // MARK: - Repositories
    
    func kakaoLoginService() -> KakaoLoginService {
        return KakaoLoginService()
    }
    
    func appleLoginService() -> AppleLoginService {
        return AppleLoginService()
    }
    
    // MARK: - Use Cases
    
    func authUseCase() -> AuthUseCase {
        return DefaultAuthUseCase()
    }
    
    func nicknameUseCase() -> NicknameUseCase {
        return DefaultNicknameUseCase()
    }
    
    func profileUseCase() -> ProfileUseCase {
        return DefaultProfileUseCase()
    }
    
    func findLocationUseCase() -> FindLocationUseCase {
        return DefaultFindLocationUseCase()
    }
    
    // MARK: - View Models
    
    func loginViewModel() -> LoginViewModel {
        return LoginViewModel(authUseCase: authUseCase())
    }
    
    func nicknameViewModel() -> NicknameViewModel {
        return NicknameViewModel(nicknameUseCase: nicknameUseCase())
    }
    
    func profileViewModel() -> ProfileViewModel {
        return ProfileViewModel(profileUseCase: profileUseCase())
    }
    
    func findLocationViewModel() -> FindLocationViewModel {
        return FindLocationViewModel(findLocationUseCase: findLocationUseCase())
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
    
    func nicknameViewController() -> NicknameViewController {
        return NicknameViewController(
            nicknameViewModel: nicknameViewModel(),
            signupViewModel: signupViewModel
        )
    }
    
    func profileViewController() -> ProfileViewController {
        return ProfileViewController(
            profileViewModel: profileViewModel(),
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
