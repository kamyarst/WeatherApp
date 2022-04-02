//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Kamyar on 4/1/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.startApplication()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

    private func startApplication() {

        let nav = UINavigationController()
        let coordinator = MainCoordinator(navigationController: nav)
        coordinator.start()

        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
}
