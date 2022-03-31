//
//  RemoteWeatherLoader.swift
//  WeatherApp
//
//  Created by Kamyar on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

public class RemoteWeatherLoader: WeatherLoader {

    let url: URL
    let client: HTTPClient

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load() async -> Result<WeatherModel, Error> {

        let result = await self.client.get(from: self.url)
        switch result {
        case let .success((data, response)):

            if response.statusCode == 200,
               let json = try? JSONDecoder().decode(WeatherModel.self, from: data) {
                return .success(json)
            } else {
                return .failure(HTTPError.invalidData)
            }

        case let .failure(error):
            return .failure(error)
        }
    }
}

protocol WeatherLoader {
    func load() async -> Result<WeatherModel, Error>
}
