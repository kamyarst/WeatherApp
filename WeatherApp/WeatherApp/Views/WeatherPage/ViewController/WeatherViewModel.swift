//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import Combine
import Foundation
import WeatherCore

final class WeatherViewModel {

    private let weatherRepository: WeatherRepository
    private lazy var locationProvider = LocationProvider()
    @Published var weatherModel: WeatherModel?
    @Published var state: WeatherState = .loading
    private var bag = Set<AnyCancellable>()

    init(weatherRepository: WeatherRepository = WeatherRepository()) {
        self.weatherRepository = weatherRepository
    }

    func getWeatherFromLocation() {

        self.locationProvider.$location.sink { [weak self] location in
            guard let self = self, case let .success(location) = location else { return }
            let geo = (location.coordinate.latitude, location.coordinate.longitude)
            self.getWeather(by: geo)
        }.store(in: &self.bag)
        self.locationProvider.requestForLocation()
    }

    func getWeather(by geo: (lat: Double, lon: Double)) {

        Task {
            let result = await self.weatherRepository.get(by: geo)
            switch result {
            case let .success(model):
                self.weatherModel = model
                self.state = .success

            case let .failure(error):
                self.state = .failed
                print(error.localizedDescription)
            }
        }
    }

    enum WeatherState {
        case loading
        case success
        case failed
    }
}
