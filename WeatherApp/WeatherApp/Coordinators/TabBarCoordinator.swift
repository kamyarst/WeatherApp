//
//  TabBarCoordinator.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = self.children.map { $0.navigationController }
        self.children.forEach { $0.start() }
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.modalTransitionStyle = .coverVertical
        self.navigationController.pushViewController(tabBarController, animated: true)
    }
}
