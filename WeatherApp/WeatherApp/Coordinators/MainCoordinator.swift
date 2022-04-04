//
//  MainCoordinator.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

final class MainCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.setupNavigationBar()
    }

    func start() {
        self.presentTabBarController()
    }

    private func setupNavigationBar() {

        self.navigationController.setNavigationBarHidden(true, animated: false)
    }

    private func presentTabBarController() {

        let tabBarCoordinator = TabBarCoordinator(navigationController: self.navigationController)
        tabBarCoordinator.children = [WeatherCoordinator(), LocationCoordinator()]
        tabBarCoordinator.start()
    }
}
