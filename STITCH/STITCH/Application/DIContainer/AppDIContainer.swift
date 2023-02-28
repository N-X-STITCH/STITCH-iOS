//
//  AppDIContainer.swift
//  STITCH
//
//  Created by neuli on 2023/02/16.
//

import Foundation

final class AppDIContainer {
    
    lazy var urlsessionNetworkService: URLSessionNetworkService = {
        let config = NetworkConfig(baseURL: URL(string: "https://api.sampleapis.com/coffee/hot")!)
        return DefaultURLSessionNetworkService(config: config)
    }()
    
    func makeAuthSceneDIContainer() -> AuthDIContainer {
        let dependencies = AuthDIContainer.Dependencies(urlsessionNetworkService: urlsessionNetworkService)
        return AuthDIContainer(dependencies: dependencies)
    }
}
