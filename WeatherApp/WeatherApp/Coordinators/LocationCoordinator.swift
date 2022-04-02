//
//  LocationCoordinator.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

final class LocationCoordinator: Coordinator {
    var children = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }

    func start() {
        let locationController = LocationViewController()
        self.navigationController.tabBarItem = .init(title: "Search",
                                                     image: UIImage(systemName: "magnifyingglass.circle"),
                                                     selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        self.navigationController.pushViewController(locationController, animated: false)
    }
}
