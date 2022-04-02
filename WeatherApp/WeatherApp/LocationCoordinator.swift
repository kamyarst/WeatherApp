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
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        self.navigationController.pushViewController(vc, animated: false)
    }
}
