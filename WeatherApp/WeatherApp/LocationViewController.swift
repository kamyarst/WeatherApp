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
        view.configGradient(with: [.systemGray6, .systemGray5], .vertical)
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
