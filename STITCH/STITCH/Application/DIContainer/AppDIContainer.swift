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
    
    func makeAuthSceneDIContainer() -> AuthDIContainer {
        let dependencies = AuthDIContainer.Dependencies(urlsessionNetworkService: urlsessionNetworkService)
        return AuthDIContainer(dependencies: dependencies)
    }
    
    func makeTabBarDIContainer() -> TabBarDIContainer {
        let dependencies = TabBarDIContainer.Dependencies(urlsessionNetworkService: urlsessionNetworkService)
        return TabBarDIContainer(dependencies: dependencies)
    }
}
