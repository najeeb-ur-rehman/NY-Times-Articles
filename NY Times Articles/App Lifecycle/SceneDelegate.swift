//
//  SceneDelegate.swift
//  NY Times Articles
//
//  Created by Najeeb on 24/10/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: ArticleCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let navigation = UINavigationController()
        appCoordinator = ArticleCoordinator(navigationController: navigation)
        appCoordinator?.start()
        
        self.window = window
        
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }

}

