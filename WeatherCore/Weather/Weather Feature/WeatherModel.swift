//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Kamyar on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

public struct WeatherModel: Codable, Equatable {
    public let location: LocationModel
    public let current: CurrentModel
    public let forecast: ForecastModel

    public static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        lhs.location.id == rhs.location.id &&
            lhs.current.lastUpdatedEpoch == rhs.current.lastUpdatedEpoch
    }
}

// MARK: - Current

public struct CurrentModel: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: ConditionModel
    let feelslikeC, feelslikeF: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
    }
}

// MARK: - ConditionModel

public struct ConditionModel: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - ForecastModel

public struct ForecastModel: Codable {
    let forecastday: [ForecastDayModel]
}

// MARK: - ForecastDayModel

public struct ForecastDayModel: Codable {
    let date: String
    let dateEpoch: Int
    let day: DayModel
    let astro: AstroModel
    let hour: [HourModel]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - AstroModel

public struct AstroModel: Codable {
    let sunrise, sunset: String

    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
    }
}

// MARK: - DayModel

public struct DayModel: Codable {
    let maxtempC, maxtempF: Double
    let mintempC, mintempF: Double
    let avgtempC, avgtempF: Double

    let dailyWillItRain, dailyChanceOfRain: Int
    let dailyWillItSnow, dailyChanceOfSnow: Int
    let condition: ConditionModel

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition
    }
}

// MARK: - HourModel

public struct HourModel: Codable {
    let timeEpoch: Int
    let time: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: ConditionModel
    let feelslikeC, feelslikeF: Double
    let willItRain, chanceOfRain: Int
    let willItSnow, chanceOfSnow: Int

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
    }
}
