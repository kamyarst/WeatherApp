//
//  WeatherAppEndToEndTests.swift
//  WeatherAppEndToEndTests
//
//  Created by adanic on 3/26/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import WeatherApp
import XCTest

class WeatherAppEndToEndTests: XCTestCase {

    func test_endToEndTestServerGetLocationResult() async {
        let url =
            URL(string: "https://api.weatherapi.com/v1/search.json?key=66a6dc4a010e4e91919132456222103&")!
        let client = URLSessionHTTPClient()
        let loader = RemoteLocationLoader(client: client, url: url)

        let result = await loader.load(by: "London")

        switch result {
        case let .success(items):
                print(items)
            XCTAssertEqual(items.isEmpty, false)
        case let .failure(error):
            XCTFail("Not expected with \(error)")
        }
    }
}
