//
//  AppDIContainer.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import Foundation

final class AppDIContainer {
    
    lazy var urlsessionNetworkService: URLSessionNetworkService = {
        let config = NetworkConfig(baseURL: URL(string: "http://Lets-env.eba-uzcfq5tn.ap-northeast-2.elasticbeanstalk.com/")!)
        return DefaultURLSessionNetworkService(config: config)
    }()
    
    let userDefaultsService: UserDefaultsService = DefaultUserDefaultsService()
    
    lazy var userUseCase: UserUseCase = DefaultUserUseCase(userStorage: userStorage)
    private lazy var userStorage: UserStorage = DefaultUserStorage(userDefaultsService: userDefaultsService)
    
    func makeAuthSceneDIContainer() -> AuthDIContainer {
        let dependencies = AuthDIContainer.Dependencies(
            urlsessionNetworkService: urlsessionNetworkService,
            userDefaultsService: userDefaultsService,
            userUseCase: userUseCase
        )
        return AuthDIContainer(dependencies: dependencies)
    }
    
    func makeTabBarDIContainer() -> TabBarDIContainer {
        let dependencies = TabBarDIContainer.Dependencies(
            urlsessionNetworkService: urlsessionNetworkService,
            userUseCase: userUseCase
        )
        return TabBarDIContainer(dependencies: dependencies)
    }
}
