//
//  RemoteCityLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

final class RemoteCityLoader: CityLoader {

    private let client: HTTPClient
    private let url: URL

    init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    func load(by name: String) async -> CityResult<[CityModel]> {
        await self.load()
    }

    func load(lat: Double, lon: Double) async -> CityResult<[CityModel]> {
        await self.load()
    }

    func load() async -> CityResult<[CityModel]> {
        let result = await self.client.get(get: self.url)
        switch result {
        case let .success((data, response)):

            if response.statusCode == 200,
               let json = try? JSONDecoder().decode([CityModel].self, from: data) {
                return .success(json)
            } else {
                return .failure(HTTPError.invalidData)
            }

        case let .failure(error):
            return .failure(error)
        }
    }
}
