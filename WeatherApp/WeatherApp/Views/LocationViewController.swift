//
//  LocationViewController.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

final class LocationViewController: UIViewController {

    private(set) lazy var backgroundView: WAGradientView = {
        let view = WAGradientView()
        let colors = [Asset.Color.gradientPrimary.color, Asset.Color.gradientAccent.color]
        view.configGradient(with: colors, .vertical)
        return view
    }()

    override func loadView() {
        super.loadView()

        self.view.insertSubview(self.backgroundView, at: 0)
        self.backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
