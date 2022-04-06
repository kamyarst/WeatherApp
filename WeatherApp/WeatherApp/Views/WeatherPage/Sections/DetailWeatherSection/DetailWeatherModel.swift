//
//  DetailWeatherModel.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import Foundation
import WeatherCore

enum Section {
    case all
}

enum DetailWeatherFactory {
    static func create(from model: WeatherModel) -> [DetailWeatherModel] {

        [.init(title: L10n.Weather.sunrise, value: model.forecast.forecastday.first?.astro.sunrise ?? "-"),
         .init(title: L10n.Weather.sunset, value: model.forecast.forecastday.first?.astro.sunset ?? "-")]
    }
}

struct DetailWeatherModel: Hashable {
    var title: String
    var value: String
    var image: String?
}
