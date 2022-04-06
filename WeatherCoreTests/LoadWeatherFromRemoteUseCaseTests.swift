// swiftlint:disable all
//  LoadWeatherFromRemoteUseCaseTests.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

@testable import WeatherCore
import XCTest

class LoadWeatherFromRemoteUseCaseTests: XCTestCase {

    func test_load_requestFromURL() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = try? await sut.load()

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestFromURL() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = try? await sut.load()
        client.setURL(url)
        _ = try? await sut.load()
        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliverErrorOnClientIssue() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        await self.expect(sut, completeWith: .connectivity) {
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
            await self.expect(sut, completeWith: .invalidData) {
                client.setURL(url)
                client.setResponse(code, data: json, at: index)
            }
        }
    }

    func test_load_deliverErrorOn200InvalidData() async {
        let (sut, client) = self.makeSUT()

        let data = Data("Invalid json".utf8)
        await self.expect(sut, completeWith: .invalidData) {
            client.setURL()
            client.setResponse(200, data: data)
        }
    }

    func test_load_deliverItemsOn200() async {
        let (sut, client) = self.makeSUT()

        let location = Mock.makeLocation(id: 1, name: "Tehran", region: "Tehran", country: "Iran",
                                         latitude: 10, longitude: 10, url: anyURL(),
                                         localTimeEpoch: 1_648_210_482, localTime: "2022-03-25 12:14")

        let condition = Mock.makeCondition(text: "condition", icon: "11", code: 12)

        let current = Mock.makeCurrent(lastUpdatedEpoch: 1_648_206_000, lastUpdated: "2022-03-25 11:00",
                                       tempC: 5, tempF: 6, isDay: 1, condition: condition,
                                       feelslikeC: 1, feelslikeF: 2)

        let astro = Mock.makeAstro(sunrise: "05:52 AM", sunset: "06:22 PM")

        let hour = Mock.makeHour(timeEpoch: 1_648_166_400, time: "2022-03-25 00:00", tempC: 1.2, tempF: 2.3,
                                 isDay: 1, condition: condition, feelslikeC: 3.4, feelslikeF: 5.6,
                                 willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0)

        let day = Mock.MakeDay(maxtempC: 10.2, maxtempF: 133, mintempC: 12, mintempF: 11, avgtempC: 20,
                               avgtempF: 20, dailyWillItRain: 1, dailyChanceOfRain: 100, dailyWillItSnow: 0,
                               dailyChanceOfSnow: 0, condition: condition)

        let forecastDay = Mock.makeForecast(date: "2022-03-25 12:14", dateEpoch: 1_648_210_482,
                                            day: day, astro: astro, hour: [hour])

        let weather = Mock.makeWeather(location: location, current: current, forecastDay: forecastDay)

        await self.expect(sut, completeWith: weather.model) {
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

    private func makeItemJson(_ items: [String: Any]) -> Data {
        let data = try? JSONSerialization.data(withJSONObject: items,
                                               options: [.withoutEscapingSlashes, .fragmentsAllowed])
        XCTAssertNotNil(data)
        return data ?? Data()
    }

    private func expect(_ sut: RemoteWeatherLoader, completeWith expectedError: HTTPError,
                        file: StaticString = #filePath, line: UInt = #line,
                        when action: () -> Void) async {

        action()

        do {
            _ = try await sut.load()
            XCTFail("Expected result \(expectedError)", file: file, line: line)
        } catch let receivedError as HTTPError {
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)
        } catch {
            XCTFail("Expected result \(error)", file: file, line: line)
        }
    }

    private func expect(_ sut: RemoteWeatherLoader, completeWith object: WeatherModel,
                        file: StaticString = #filePath, line: UInt = #line,
                        when action: () -> Void) async {

        action()

        do {
            let receivedResult = try await sut.load()
            XCTAssertEqual(receivedResult, object, file: file, line: line)
        } catch {
            XCTFail("Expected result \(object)", file: file, line: line)
        }
    }
}
