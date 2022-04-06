// swiftlint:disable all
//  Mock.swift
//  WeatherCoreTests
//
//  Created by Kamyar on 4/6/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import WeatherCore
import Foundation

struct Mock {

    static func makeWeather(location: (model: LocationModel, json: [String: Any]),
                            current: (model: CurrentModel, json: [String: Any]),
                            forecastDay: (model: ForecastDayModel, json: [String: Any]))
        -> (model: WeatherModel, json: [String: Any]) {

        let item = WeatherModel(location: location.model, current: current.model,
                                forecast: .init(forecastday: [forecastDay.model]))
        let forcastDayJson = ["forecastday": [forecastDay.json]]
        let json = ["location": location.json,
                    "current": current.json,
                    "forecast": forcastDayJson] as [String: Any]
        return (item, json)
    }

    static func makeCurrent(lastUpdatedEpoch: Int, lastUpdated: String, tempC: Double, tempF: Double,
                            isDay: Int, condition: (model: ConditionModel, json: [String: Any]),
                            feelslikeC: Double,
                            feelslikeF: Double) -> (model: CurrentModel, json: [String: Any]) {

        let item = CurrentModel(lastUpdatedEpoch: lastUpdatedEpoch, lastUpdated: lastUpdated, tempC: tempC,
                                tempF: tempF, isDay: isDay, condition: condition.model,
                                feelslikeC: feelslikeC,
                                feelslikeF: feelslikeF)

        let json = ["last_updated_epoch": lastUpdatedEpoch,
                    "last_updated": lastUpdated,
                    "temp_c": tempC,
                    "temp_f": tempF,
                    "is_day": isDay,
                    "condition": condition.json,
                    "feelslike_c": feelslikeC,
                    "feelslike_f": feelslikeF] as [String: Any]
        return (item, json)
    }

    static func makeCondition(text: String, icon: String,
                              code: Int) -> (model: ConditionModel, json: [String: Any]) {

        let item = ConditionModel(text: text, icon: icon, code: code)

        let json = ["text": text,
                    "icon": icon,
                    "code": code] as [String: Any]

        return (item, json)
    }

    static func makeForecast(date: String, dateEpoch: Int,
                             day: (model: DayModel, json: [String: Any]),
                             astro: (model: AstroModel, json: [String: Any]),
                             hour: [(model: HourModel, json: [String: Any])])
        -> (model: ForecastDayModel, json: [String: Any]) {

        let item = ForecastDayModel(date: date, dateEpoch: dateEpoch, day: day.model, astro: astro.model,
                                    hour: hour.map { $0.model })

        let json = ["date": date,
                    "date_epoch": dateEpoch,
                    "day": day.json,
                    "astro": astro.json,
                    "hour": hour.map { $0.json }] as [String: Any]

        return (item, json)
    }

    static func makeLocation(id: Int, name: String, region: String?, country: String?, latitude: Double,
                             longitude: Double, url: URL, localTimeEpoch: Int?,
                             localTime: String?) -> (model: LocationModel, json: [String: Any]) {

        let item = LocationModel(id: id, name: name, region: region, country: country, latitude: latitude,
                                 longitude: longitude, url: url, localTimeEpoch: localTimeEpoch,
                                 localTime: localTime)
        let json = ["id": item.id as Any,
                    "name": item.name,
                    "region": item.region as Any,
                    "country": item.country as Any,
                    "lat": item.latitude,
                    "lon": item.longitude,
                    "url": item.url?.absoluteString as Any].compactMapValues { $0 }
        return (item, json)
    }

    static func makeAstro(sunrise: String, sunset: String) -> (model: AstroModel, json: [String: Any]) {

        let item = AstroModel(sunrise: sunrise, sunset: sunset)

        let json = ["sunrise": item.sunrise, "sunset": item.sunset]

        return (item, json)
    }

    static func makeHour(timeEpoch: Int, time: String, tempC: Double, tempF: Double, isDay: Int,
                         condition: (model: ConditionModel, json: [String: Any]),
                         feelslikeC: Double, feelslikeF: Double, willItRain: Int, chanceOfRain: Int,
                         willItSnow: Int,
                         chanceOfSnow: Int) -> (model: HourModel, json: [String: Any]) {

        let item = HourModel(timeEpoch: timeEpoch, time: time, tempC: tempC, tempF: tempF, isDay: isDay,
                             condition: condition.model, feelslikeC: feelslikeC, feelslikeF: feelslikeF,
                             willItRain: willItRain, chanceOfRain: chanceOfRain, willItSnow: willItSnow,
                             chanceOfSnow: chanceOfSnow)

        let json = ["time_epoch": timeEpoch,
                    "time": time,
                    "temp_c": tempC,
                    "temp_f": tempF,
                    "is_day": isDay,
                    "condition": condition.json,
                    "feelslike_c": feelslikeC,
                    "feelslike_f": feelslikeF,
                    "will_it_rain": willItRain,
                    "chance_of_rain": chanceOfRain,
                    "will_it_snow": willItSnow,
                    "chance_of_snow": chanceOfSnow] as [String: Any]
        return (item, json)
    }

    static func MakeDay(maxtempC: Double, maxtempF: Double, mintempC: Double, mintempF: Double,
                        avgtempC: Double,
                        avgtempF: Double, dailyWillItRain: Int, dailyChanceOfRain: Int, dailyWillItSnow: Int,
                        dailyChanceOfSnow: Int,
                        condition: (model: ConditionModel, json: [String: Any]))
        -> (model: DayModel, json: [String: Any]) {

        let item = DayModel(maxtempC: maxtempC, maxtempF: maxtempF, mintempC: mintempC, mintempF: mintempF,
                            avgtempC: avgtempC, avgtempF: avgtempF, dailyWillItRain: dailyWillItRain,
                            dailyChanceOfRain: dailyChanceOfRain, dailyWillItSnow: dailyWillItSnow,
                            dailyChanceOfSnow: dailyChanceOfSnow, condition: condition.model)

        let json = ["maxtemp_c": maxtempC,
                    "maxtemp_f": maxtempF,
                    "mintemp_c": mintempC,
                    "mintemp_f": mintempF,
                    "avgtemp_c": avgtempC,
                    "avgtemp_f": avgtempF,
                    "daily_will_it_rain": dailyWillItRain,
                    "daily_chance_of_rain": dailyChanceOfRain,
                    "daily_will_it_snow": dailyWillItSnow,
                    "condition": condition.json,
                    "daily_chance_of_snow": dailyChanceOfSnow] as [String: Any]
        return (item, json)
    }
}
