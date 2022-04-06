// swiftlint:disable force_unwrapping
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
        await XCTAssertNoThrowsError(try await self.getLocationResult(for: .getByName(name: location)))
    }

    func test_endToEndTestServerGetLocationResultByLatAndLon() async {

        let geo = (lat: 51.49, lon: -0.12)
        await XCTAssertNoThrowsError(try await self
            .getLocationResult(for: .getByGeo(lat: geo.lat, lon: geo.lon)))
    }

    // MARK: - Helpers

    private func getLocationResult(for endpoint: LocationEndpoint,
                                   file: StaticString = #filePath,
                                   line: UInt = #line) async throws -> [LocationModel] {
        
        let url = endpoint.url
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        let loader = RemoteLocationLoader(client: client, url: url)
        trackMemoryLeak(client, file: file, line: line)
        trackMemoryLeak(loader, file: file, line: line)
        return try await loader.load()
    }
}
