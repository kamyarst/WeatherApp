//
//  WeatherViewController+SetupViews.swift
//  WeatherApp
//
//  Created by Kamyar on 4/4/22.
//

import UIKit

extension WeatherViewController {

    func setupViews() {

        self.setupRefreshControl()
        self.setupBackgroundView()
        self.containerStackView.addArrangedSubview(self.titleLabel)
        self.containerStackView.addArrangedSubview(self.currentWeatherView)
        self.appendSeparator()
        self.containerStackView.addArrangedSubview(self.hourlyForecastView)
        self.containerStackView.addArrangedSubview(self.dailyForecastView)
    }

    private func setupRefreshControl() {
        self.scrollView.refreshControl = self.refreshControl
    }

    private func setupBackgroundView() {

        self.view.insertSubview(self.backgroundView, at: 0)
        self.backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func appendSeparator() {

        let separator = UIView()
        separator.backgroundColor = .white.withAlphaComponent(0.3)
        self.containerStackView.addArrangedSubview(separator)
        separator.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
    }
}
