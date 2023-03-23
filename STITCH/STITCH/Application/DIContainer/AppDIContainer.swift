//
//  AppDIContainer.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import Foundation

final class AppDIContainer {
    
    // MARK: - Service
    
    lazy var urlsessionNetworkService: URLSessionNetworkService = {
        let config = NetworkConfig(baseURL: URL(string: "http://Lets-env.eba-uzcfq5tn.ap-northeast-2.elasticbeanstalk.com")!)
        return DefaultURLSessionNetworkService(config: config)
    }()
    
    lazy var naverCloudAPIService: URLSessionNetworkService = {
        let config = NetworkConfig(
            baseURL: URL(string: "https://naveropenapi.apigw.ntruss.com/")!,
            headers: [
                "X-NCP-APIGW-API-KEY-ID": APIKey.naverCloudClientID,
                "X-NCP-APIGW-API-KEY": APIKey.naverCloudClientSecret
            ]
        )
        return DefaultURLSessionNetworkService(config: config)
    }()
    
    lazy var naverOpenAPIService: URLSessionNetworkService = {
        let config = NetworkConfig(
            baseURL: URL(string: "https://openapi.naver.com/v1/search/local.json")!,
            headers: [
                "X-Naver-Client-Id": APIKey.naverClientID,
                "X-Naver-Client-Secret": APIKey.naverClientSecret
            ]
        )
        return DefaultURLSessionNetworkService(config: config)
    }()
    
    lazy var appleIDService: URLSessionNetworkService = {
        let config = NetworkConfig(
            baseURL: URL(string: "https://appleid.apple.com/")!
        )
        return DefaultURLSessionNetworkService(config: config)
    }()
    
    let userDefaultsService: UserDefaultsService = DefaultUserDefaultsService()
    
    // MARK: - Properties
    
    lazy var userUseCase: UserUseCase = DefaultUserUseCase(userStorage: userStorage)
    private lazy var userStorage: UserStorage = DefaultUserStorage(userDefaultsService: userDefaultsService)
    
    // MARK: - Methods
    
    func makeAuthSceneDIContainer() -> AuthDIContainer {
        let dependencies = AuthDIContainer.Dependencies(
            urlsessionNetworkService: urlsessionNetworkService,
            naverCloudAPIService: naverCloudAPIService,
            userDefaultsService: userDefaultsService,
            userUseCase: userUseCase
        )
        return AuthDIContainer(dependencies: dependencies)
    }
    
    func makeTabBarDIContainer() -> TabBarDIContainer {
        let dependencies = TabBarDIContainer.Dependencies(
            urlsessionNetworkService: urlsessionNetworkService,
            userDefaultsService: userDefaultsService,
            naverCloudAPIService: naverCloudAPIService,
            naverOpenAPIService: naverOpenAPIService,
            appleIDService: appleIDService,
            userUseCase: userUseCase
        )
        return TabBarDIContainer(dependencies: dependencies)
    }
}
