//
//  SceneDelegate.swift
//  WeatherTest
//
//  Created by Polina on 26.03.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
            _ scene: UIScene,
            willConnectTo session: UISceneSession,
            options connectionOptions: UIScene.ConnectionOptions
        ) {
            guard let windowScene = (scene as? UIWindowScene) else { return }

            let window = UIWindow(windowScene: windowScene)

            let navController = UINavigationController(rootViewController: HomeViewController())

            window.rootViewController = navController
            self.window = window
            window.makeKeyAndVisible()
        }


}

