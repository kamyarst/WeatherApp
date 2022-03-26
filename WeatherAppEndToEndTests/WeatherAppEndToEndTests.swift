//
//  WeatherAppEndToEndTests.swift
//  WeatherAppEndToEndTests
//
//  Created by Kamyar Sehati on 3/26/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import WeatherApp
import XCTest

class WeatherAppEndToEndTests: XCTestCase {

    func test_endToEndTestServerGetLocationResultByName() async {

        let result = await self.getLocationResult(for: .getByName(name: "London"))

        switch result {
        case let .success(items):
            print(items)
            XCTAssertEqual(items.isEmpty, false)

        case let .failure(error):
            XCTFail("Not expected with \(error)")
        }
    }

    func test_endToEndTestServerGetLocationResultByLatAndLon() async {

        let result = await self.getLocationResult(for: .getByGeo(lat: 51.52, lon: -0.11))

        switch result {
        case let .success(items):
            print(items)
            XCTAssertEqual(items.isEmpty, false)

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
        let client = URLSessionHTTPClient()
        let loader = RemoteLocationLoader(client: client, url: url)
        trackMemoryLeak(client, file: file, line: line)
        trackMemoryLeak(loader, file: file, line: line)
        return await loader.load()
    }
}
