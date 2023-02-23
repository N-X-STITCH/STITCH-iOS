//
//  SceneDelegate.swift
//  STITCH
//
//  Created by neuli on 2023/02/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDIContainer = AppDIContainer()
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        start(windowScene)
    }
    
    func start(_ windowScene: UIWindowScene) {
        let navigationController = UINavigationController()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.backgroundColor = .background // TODO: color 변경
        window?.makeKeyAndVisible()
        
        appCoordinator = AppCoordinator(navigationController, appDIContainer: appDIContainer)
        appCoordinator?.start()
        
        // TODO: appCoordinator 추가
        // appCoordinator start
    }
}

