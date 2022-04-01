//
//  LocationEndToEndTests.swift
//  LocationEndToEndTests
//
//  Created by Kamyar Sehati on 3/26/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

@testable import WeatherCore
import XCTest

class LocationEndToEndTests: XCTestCase {

    func test_endToEndTestServerGetLocationResultByName() async {

        let location = "London"
        let result = await self.getLocationResult(for: .getByName(name: location))

        switch result {
        case let .success(items):
            XCTAssertFalse(items.filter { $0.name.contains(location) }.isEmpty)
            XCTAssertFalse(items.isEmpty)

        case let .failure(error):
            XCTFail("Not expected with \(error)")
        }
    }

    func test_endToEndTestServerGetLocationResultByLatAndLon() async {

        let geo = (lat: 51.49, lon: -0.12)
        let result = await self.getLocationResult(for: .getByGeo(lat: geo.lat, lon: geo.lon))

        switch result {
        case let .success(items):
            XCTAssertTrue(items.contains(where: { $0.latitude == geo.lat && $0.longitude == geo.lon }))
            XCTAssertFalse(items.isEmpty)

        case let .failure(error):
            XCTFail("Not expected with \(error)")
        }
    }

    // MARK: - Helpers

    private func getLocationResult(for endpoint: LocationEndpoint,
                                   file: StaticString = #filePath,
                                   line: UInt = #line) async -> LocationResult<[LocationModel]> {
        let key = "66a6dc4a010e4e91919132456222103"
        let base = URL(string: "https://api.weatherapi.com")!
        let url = endpoint.url(baseURL: base, key: key)
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteLocationLoader(client: client, url: url)
        trackMemoryLeak(client, file: file, line: line)
        trackMemoryLeak(loader, file: file, line: line)
        return await loader.load()
    }
}

class WeatherEndToEndTests: XCTestCase {

    func test_endToEndTestServerGetLocationResultByName() async {

        let location = "London"
        let result = await self.getLocationResult(for: .getByName(name: location))

        switch result {
        case let .success(item):
                print(item)
            XCTAssertTrue(item.location.name.contains(location))

        case let .failure(error):
            XCTFail("Not expected with \(error)")
        }
    }

    func test_endToEndTestServerGetLocationResultByLatAndLon() async {

        let geo = (lat: 51.49, lon: -0.12)
        let result = await self.getLocationResult(for: .getByGeo(lat: geo.lat, lon: geo.lon))

        switch result {
        case let .success(item):
            XCTAssertTrue(item.location.latitude == geo.lat)
            XCTAssertTrue(item.location.longitude == geo.lon)

        case let .failure(error):
            XCTFail("Not expected with \(error)")
        }
    }

    // MARK: - Helpers

    private func getLocationResult(for endpoint: WeatherEndpoint,
                                   file: StaticString = #filePath,
                                   line: UInt = #line) async -> Result<WeatherModel, Error> {
        let key = "66a6dc4a010e4e91919132456222103"
        let base = URL(string: "https://api.weatherapi.com")!
        let url = endpoint.url(baseURL: base, key: key)
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteWeatherLoader(url: url, client: client)
        trackMemoryLeak(client, file: file, line: line)
        trackMemoryLeak(loader, file: file, line: line)
        return await loader.load()
    }
}
