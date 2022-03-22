//
//  RemoteCityLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

final class RemoteCityLoader {

    private let client: HTTPClient
    private let url: URL

    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    func load() async -> HTTPResult<[CityModel]> {

        let result = await self.client.get(get: self.url)
        switch result {
        case let .success((data, response)):

            if response.statusCode == 200,
               let json = try? JSONDecoder().decode([CityModel].self, from: data) {
                return .success(json)
            } else {
                return .failure(.invalidData)
            }

        case let .failure(error):
            return .failure(error)
        }
    }
}
