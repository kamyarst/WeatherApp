//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

final class WeatherViewController: WAScrollViewController {

    // MARK: - Constants

    // MARK: - Logical Variables

    // MARK: - UI Variables

    private(set) lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = .white
        view.backgroundColor = Asset.Color.gradientPrimary.color
        view.attributedTitle = .init(string: L10n.General.wait,
                                     attributes: [.foregroundColor: UIColor.white])
        view.addTarget(self, action: #selector(refreshDidBegin), for: .valueChanged)
        return view
    }()

    private(set) lazy var backgroundView: WAGradientView = {
        let view = WAGradientView()
        let colors = [Asset.Color.gradientPrimary.color, Asset.Color.gradientAccent.color]
        view.configGradient(with: colors, .vertical)
        return view
    }()

    private(set) lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = WAFont.dynamicFont(.bold, .largeTitle)
        view.text = "   Hello"
        return view
    }()

    private(set) lazy var currentWeatherView: CurrentWeatherView = {
        let view = CurrentWeatherView()
        return view
    }()

    private(set) lazy var hourlyForecastView: HourlyForecastView = {
        let view = HourlyForecastView()
        return view
    }()

    private(set) lazy var dailyForecastView: DailyForecastView = {
        let view = DailyForecastView()
        view.backgroundColor = .white.withAlphaComponent(0.15)
        return view
    }()

    // MARK: - View Lifecycles

    override func loadView() {
        super.loadView()

        self.setupViews()
    }

    // MARK: - Binders

    // MARK: - Validation Checks

    // MARK: - UI Configurations

    // MARK: - Functions

    // MARK: - Targets

    @objc private func refreshDidBegin() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshControl.endRefreshing()
        }
    }
}
