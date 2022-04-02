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
        let vc = UIViewController()
        vc.view.backgroundColor = .red
        self.navigationController.pushViewController(vc, animated: false)
    }
}
