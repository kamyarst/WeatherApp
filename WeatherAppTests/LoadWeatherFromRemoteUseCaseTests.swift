// swiftlint:disable all
//  LoadWeatherFromRemoteUseCaseTests.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

@testable import WeatherApp
import XCTest

class LoadWeatherFromRemoteUseCaseTests: XCTestCase {

    func test_load_requestFromURL() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = await sut.load()

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestFromURL() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = await sut.load()
        client.setURL(url)
        _ = await sut.load()

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliverErrorOnClientIssue() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        await self.expect(sut, completeWith: .failure(HTTPError.connectivity)) {
            client.setURL(url)
            client.setError(.connectivity)
        }
    }

    func test_load_deliverErrorOnNon200() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        let codes = [199, 201, 300, 400, 500]
        for (index, code) in codes.enumerated() {
            let json = self.makeItemJson(["": ""])
            await self.expect(sut, completeWith: .failure(HTTPError.invalidData)) {
                client.setURL(url)
                client.setResponse(code, data: json, at: index)
            }
        }
    }

    func test_load_deliverErrorOn200InvalidData() async {
        let (sut, client) = self.makeSUT()

        let data = Data("Invalid json".utf8)
        await self.expect(sut, completeWith: .failure(HTTPError.invalidData)) {
            client.setURL()
            client.setResponse(200, data: data)
        }
    }

    func test_load_deliverItemsOn200() async {
        let (sut, client) = self.makeSUT()

        let location = self.makeLocation(id: 1, name: "Tehran", region: "Tehran", country: "Iran",
                                         latitude: 10, longitude: 10, url: anyURL(),
                                         localTimeEpoch: 1_648_210_482, localTime: "2022-03-25 12:14")

        let condition = self.makeCondition(text: "condition", icon: "11", code: 12)

        let current = self.makeCurrent(lastUpdatedEpoch: 1_648_206_000, lastUpdated: "2022-03-25 11:00",
                                       tempC: 5, tempF: 6, isDay: 1, condition: condition,
                                       feelslikeC: 1, feelslikeF: 2)

        let astro = self.makeAstro(sunrise: "05:52 AM", sunset: "06:22 PM")

        let hour = self.makeHour(timeEpoch: 1_648_166_400, time: "2022-03-25 00:00", tempC: 1.2, tempF: 2.3,
                                 isDay: 1, condition: condition, feelslikeC: 3.4, feelslikeF: 5.6,
                                 willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0)

        let day = self.MakeDay(maxtempC: 10.2, maxtempF: 133, mintempC: 12, mintempF: 11, avgtempC: 20,
                               avgtempF: 20, dailyWillItRain: 1, dailyChanceOfRain: 100, dailyWillItSnow: 0,
                               dailyChanceOfSnow: 0, condition: condition)

        let forecastDay = self.makeForecast(date: "2022-03-25 12:14", dateEpoch: 1_648_210_482,
                                            day: day, astro: astro, hour: [hour])

        let weather = self.makeWeather(location: location, current: current, forecastDay: forecastDay)

        await self.expect(sut, completeWith: .success(weather.model)) {
            let json = makeItemJson(weather.json)
            client.setURL()
            client.setResponse(200, data: json)
        }
    }

    // MARK: - Helpers

    private func makeSUT(url: URL = anyURL())
        -> (sut: RemoteWeatherLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteWeatherLoader(url: url, client: client)
        trackMemoryLeak(sut)
        trackMemoryLeak(client)
        return (sut, client)
    }

    private func makeWeather(location: (model: LocationModel, json: [String: Any]),
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

    private func makeCurrent(lastUpdatedEpoch: Int, lastUpdated: String, tempC: Double, tempF: Double,
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

    private func makeCondition(text: String, icon: String,
                               code: Int) -> (model: ConditionModel, json: [String: Any]) {

        let item = ConditionModel(text: text, icon: icon, code: code)

        let json = ["text": text,
                    "icon": icon,
                    "code": code] as [String: Any]

        return (item, json)
    }

    private func makeForecast(date: String, dateEpoch: Int,
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

    private func makeLocation(id: Int, name: String, region: String?, country: String?, latitude: Double,
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

    func makeAstro(sunrise: String, sunset: String) -> (model: AstroModel, json: [String: Any]) {

        let item = AstroModel(sunrise: sunrise, sunset: sunset)

        let json = ["sunrise": item.sunrise, "sunset": item.sunset]

        return (item, json)
    }

    func makeHour(timeEpoch: Int, time: String, tempC: Double, tempF: Double, isDay: Int,
                  condition: (model: ConditionModel, json: [String: Any]),
                  feelslikeC: Double, feelslikeF: Double, willItRain: Int, chanceOfRain: Int, willItSnow: Int,
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

    func MakeDay(maxtempC: Double, maxtempF: Double, mintempC: Double, mintempF: Double, avgtempC: Double,
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

    private func makeItemJson(_ items: [String: Any]) -> Data {
        let data = try? JSONSerialization.data(withJSONObject: items,
                                               options: [.withoutEscapingSlashes, .fragmentsAllowed])
        XCTAssertNotNil(data)
        return data ?? Data()
    }

    private func expect(_ sut: RemoteWeatherLoader, completeWith expectedResult: HTTPResult<WeatherModel>,
                        file: StaticString = #filePath, line: UInt = #line,
                        when action: () -> Void) async {

        action()
        let receivedResult = await sut.load()

        switch (receivedResult, expectedResult) {
        case let (.success(receivedItems), .success(expectedItems)):
            XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)

        case let (.failure(receivedError as HTTPError), .failure(expectedError as HTTPError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)

        default:
            XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file,
                    line: line)
        }
    }
}
