//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import Combine
import UIKit

final class WeatherViewController: WAScrollViewController {

    // MARK: - Constants

    private var bag = Set<AnyCancellable>()

    // MARK: - Logical Variables

    private let viewModel = WeatherViewModel()

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

    private(set) lazy var detailWeatherView: DetailWeatherView = {
        let view = DetailWeatherView()
        return view
    }()

    // MARK: - View Lifecycles

    override func loadView() {
        super.loadView()

        self.setupViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.bindState()
        self.bindViewModel()
        self.viewModel.getWeatherFromLocation()
    }

    // MARK: - Binders

    private func bindViewModel() {

        self.viewModel.$weatherModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self, let model = model else { return }
                self.currentWeatherView.locationLabel.text = model.location.name
                self.currentWeatherView.regionLabel.text = (model.location.region ?? "") +
                    ", " +
                    (model.location.country ?? "")
                self.currentWeatherView.currentDegreeLabel.text = "\(Int(model.current.tempC))"
                self.currentWeatherView.currentWeatherLabel.text = model.current.condition.text
                self.currentWeatherView.feelLikeLabel.text = L10n.Weather
                    .feelsLike(Int(model.current.feelslikeC))
                self.currentWeatherView.upTrendImageLabel.titleLabel
                    .text = "\(Int(model.forecast.forecastday.first?.day.maxtempC ?? 0))"
                self.currentWeatherView.lowTrendImageLabel.titleLabel
                    .text = "\(Int(model.forecast.forecastday.first?.day.mintempC ?? 0))"
                let icon = model.current.condition.code
                if let imageName = WeatherIconFactory.get(code: icon, isDay: model.current.isDay) {
                    self.currentWeatherView.currentIconImageView.image = UIImage(systemName: imageName)
                }
            }
            .store(in: &self.bag)

        self.viewModel.$weatherModel
            .compactMap { $0?.forecast.forecastday.first?.hour }
            .compactMap { $0.filter { Date(string: $0.time) >= Date() } }
            .sink { model in
                self.hourlyForecastView.updateSnapshot(with: model)
            }
            .store(in: &self.bag)

        self.viewModel.$weatherModel
            .compactMap { $0?.forecast.forecastday }
            .sink { model in
                self.dailyForecastView.updateSnapshot(with: model)
            }
            .store(in: &self.bag)

        self.viewModel.$weatherModel
            .compactMap { $0 }
            .compactMap { DetailWeatherFactory.create(from: $0) }
            .sink { model in
                self.detailWeatherView.updateSnapshot(with: model)
            }.store(in: &self.bag)
    }

    private func bindState() {

        self.viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }
                switch state {
                case .success, .failed:
                    self.refreshControl.endRefreshing()

                case .loading:
                    self.refreshControl.beginRefreshing()
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: -100),
                                                     animated: true)
                }
            }
            .store(in: &self.bag)
    }

    // MARK: - Targets

    @objc private func refreshDidBegin() {

        self.viewModel.getWeatherFromLocation()
    }
}
