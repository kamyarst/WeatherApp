//
//  WeatherRepository.swift
//  WeatherCore
//
//  Created by adanic on 4/4/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

public class WeatherRepository {

    private typealias Endpoint = WeatherEndpoint
    private let client: HTTPClient

    public init(client: HTTPClient = URLSessionHTTPClient()) {
        self.client = client
    }

    public func get(by geo: (lat: Double, lon: Double)) async -> Result<WeatherModel, Error> {

        let hasNetwork = true
        if hasNetwork {
            return await self.loadFromServer(by: geo)
        } else {
            // read data from cache
            fatalError("not implemented")
        }
    }

    public func get(by name: String) async -> Result<WeatherModel, Error> {

        let hasNetwork = true
        if hasNetwork {
            return await self.loadFromServer(by: name)
        } else {
            // read data from cache
            fatalError("not implemented")
        }
    }

    private func loadFromServer(by name: String) async -> Result<WeatherModel, Error> {

        let url = Endpoint.getByName(name: name).url
        let loader = RemoteWeatherLoader(url: url, client: client)
        do {
            let result = try await loader.load()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }

    private func loadFromServer(by geo: (lat: Double, lon: Double)) async -> Result<WeatherModel, Error> {

        let url = Endpoint.getByGeo(lat: geo.lat, lon: geo.lon).url
        let loader = RemoteWeatherLoader(url: url, client: client)
        do {
            let result = try await loader.load()
            return .success(result)
        } catch {
            return .failure(error)
        }
    }
}
