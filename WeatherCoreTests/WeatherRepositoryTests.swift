//
//  WeatherRepositoryTests.swift
//  WeatherCoreTests
//
//  Created by Kamyar on 4/4/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//
@testable import WeatherCore
import XCTest

protocol WeatherRepositoryTestCases {
    func test_getWeatherByGeoFromServerSuccess() async
    func test_getWeatherByGeoFromServerFailure() async
    func test_getWeatherByNameFromServerSuccess() async
    func test_getWeatherByNameFromServerFailure() async
    func test_getWeatherByGeoFromCacheSuccess() async
    func test_getWeatherByGeoFromCacheFailure() async
    func test_getWeatherByNameFromCacheSuccess() async
    func test_getWeatherByNameFromCacheFailure() async
}

class WeatherRepositoryTests: XCTestCase, WeatherRepositoryTestCases {

    func test_getWeatherByGeoFromServerSuccess() async { }

    func test_getWeatherByGeoFromServerFailure() async { }

    func test_getWeatherByNameFromServerSuccess() async { }

    func test_getWeatherByNameFromServerFailure() async { }

    func test_getWeatherByGeoFromCacheSuccess() async { }

    func test_getWeatherByGeoFromCacheFailure() async { }

    func test_getWeatherByNameFromCacheSuccess() async { }

    func test_getWeatherByNameFromCacheFailure() async { }

    // MARK: - Helpers

    private func makeSUT() -> (sut: WeatherRepository, client: HTTPClientSpy) {

        let client = HTTPClientSpy()
        let sut = WeatherRepository(client: client)
        trackMemoryLeak(sut)
        return (sut, client)
    }
}
