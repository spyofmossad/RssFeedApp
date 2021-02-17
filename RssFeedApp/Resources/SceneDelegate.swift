//
//  SceneDelegate.swift
//  RssFeedApp
//
//  Created by Dmitry on 16.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navController = UINavigationController()
        let dataProvider = DataProvider()
        let networkService = NetworkService()
        let screenBuilder = ScreenBuilder(dataProvider: dataProvider, networkService: networkService)
        
        appCoordinator = AppCoordinator(naviationController: navController, screenBuilder: screenBuilder)
        appCoordinator?.start()
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
