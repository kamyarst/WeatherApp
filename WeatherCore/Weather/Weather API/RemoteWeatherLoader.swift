//
//  RemoteWeatherLoader.swift
//  WeatherApp
//
//  Created by Kamyar on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

protocol WeatherLoader {
    func load() async throws -> WeatherModel
}

public class RemoteWeatherLoader: WeatherLoader {

    let url: URL
    let client: HTTPClient

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load() async throws -> WeatherModel {

        let result = try await self.client.get(from: self.url)
        if result.response.statusCode == 200,
           let json = try? JSONDecoder().decode(WeatherModel.self, from: result.data) {
            return json
        } else {
            throw HTTPError.invalidData
        }
    }
}
