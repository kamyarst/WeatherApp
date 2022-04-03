//
//  WeatherCoordinator.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

final class WeatherCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {

        let weatherController = WeatherViewController()
        self.navigationController.tabBarItem = .init(title: L10n.WeatherController.TabBar.title,
                                                     image: UIImage(systemName: "location.circle"),
                                                     selectedImage: UIImage(systemName: "location.circle.fill"))
        self.navigationController.pushViewController(weatherController, animated: false)
        self.setupNavigationBar()
    }

    private func setupNavigationBar() {

        self.navigationController.navigationBar.prefersLargeTitles = true
    }
}
