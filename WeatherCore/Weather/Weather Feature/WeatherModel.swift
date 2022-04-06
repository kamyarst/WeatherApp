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

    public init(location: LocationModel, current: CurrentModel, forecast: ForecastModel) {
        self.location = location
        self.current = current
        self.forecast = forecast
    }

    public static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        lhs.location.id == rhs.location.id &&
            lhs.current.lastUpdatedEpoch == rhs.current.lastUpdatedEpoch
    }
}

// MARK: - Current

public struct CurrentModel: Codable {

    public let lastUpdatedEpoch: Int
    public let lastUpdated: String
    public let tempC, tempF: Double
    public let isDay: Int
    public let condition: ConditionModel
    public let feelslikeC, feelslikeF: Double

    public init(lastUpdatedEpoch: Int, lastUpdated: String, tempC: Double, tempF: Double, isDay: Int,
                condition: ConditionModel, feelslikeC: Double, feelslikeF: Double) {
        self.lastUpdatedEpoch = lastUpdatedEpoch
        self.lastUpdated = lastUpdated
        self.tempC = tempC
        self.tempF = tempF
        self.isDay = isDay
        self.condition = condition
        self.feelslikeC = feelslikeC
        self.feelslikeF = feelslikeF
    }

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

public struct ConditionModel: Codable, Hashable {

    public let text, icon: String
    public let code: Int

    public init(text: String, icon: String, code: Int) {
        self.text = text
        self.icon = icon
        self.code = code
    }
}

// MARK: - ForecastModel

public struct ForecastModel: Codable {

    public let forecastday: [ForecastDayModel]

    public init(forecastday: [ForecastDayModel]) {
        self.forecastday = forecastday
    }
}

// MARK: - ForecastDayModel

public struct ForecastDayModel: Codable, Hashable {

    public let date: String
    public let dateEpoch: Int
    public let day: DayModel
    public let astro: AstroModel
    public let hour: [HourModel]

    public init(date: String, dateEpoch: Int, day: DayModel, astro: AstroModel, hour: [HourModel]) {
        self.date = date
        self.dateEpoch = dateEpoch
        self.day = day
        self.astro = astro
        self.hour = hour
    }

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - AstroModel

public struct AstroModel: Codable, Hashable {

    public let sunrise, sunset: String

    public init(sunrise: String, sunset: String) {
        self.sunrise = sunrise
        self.sunset = sunset
    }

    enum CodingKeys: String, CodingKey {
        case sunrise
        case sunset
    }
}

// MARK: - DayModel

public struct DayModel: Codable, Hashable {

    public let maxtempC, maxtempF: Double
    public let mintempC, mintempF: Double
    public let avgtempC, avgtempF: Double

    public let dailyWillItRain, dailyChanceOfRain: Int
    public let dailyWillItSnow, dailyChanceOfSnow: Int
    public let condition: ConditionModel

    public init(maxtempC: Double, maxtempF: Double, mintempC: Double, mintempF: Double, avgtempC: Double,
                avgtempF: Double, dailyWillItRain: Int, dailyChanceOfRain: Int, dailyWillItSnow: Int,
                dailyChanceOfSnow: Int, condition: ConditionModel) {
        self.maxtempC = maxtempC
        self.maxtempF = maxtempF
        self.mintempC = mintempC
        self.mintempF = mintempF
        self.avgtempC = avgtempC
        self.avgtempF = avgtempF
        self.dailyWillItRain = dailyWillItRain
        self.dailyChanceOfRain = dailyChanceOfRain
        self.dailyWillItSnow = dailyWillItSnow
        self.dailyChanceOfSnow = dailyChanceOfSnow
        self.condition = condition
    }

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

public struct HourModel: Codable, Hashable {

    public let timeEpoch: Int
    public let time: String
    public let tempC, tempF: Double
    public let isDay: Int
    public let condition: ConditionModel
    public let feelslikeC, feelslikeF: Double
    public let willItRain, chanceOfRain: Int
    public let willItSnow, chanceOfSnow: Int

    public init(timeEpoch: Int, time: String, tempC: Double, tempF: Double, isDay: Int,
                condition: ConditionModel, feelslikeC: Double, feelslikeF: Double, willItRain: Int,
                chanceOfRain: Int, willItSnow: Int, chanceOfSnow: Int) {
        self.timeEpoch = timeEpoch
        self.time = time
        self.tempC = tempC
        self.tempF = tempF
        self.isDay = isDay
        self.condition = condition
        self.feelslikeC = feelslikeC
        self.feelslikeF = feelslikeF
        self.willItRain = willItRain
        self.chanceOfRain = chanceOfRain
        self.willItSnow = willItSnow
        self.chanceOfSnow = chanceOfSnow
    }

    public static func == (lhs: HourModel, rhs: HourModel) -> Bool {
        lhs.timeEpoch == rhs.timeEpoch
    }

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
