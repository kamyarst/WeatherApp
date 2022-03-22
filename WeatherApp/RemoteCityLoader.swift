//
//  RemoteCityLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

typealias result<T> = Result<T, Error>
typealias HTTPResult<T> = Result<T, HTTPError>

protocol HTTPClient {
    func get(get url: URL) async -> HTTPResult<(Data, HTTPURLResponse)>
}

enum HTTPError: Error {
    case connectivity
    case invalidData
}

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
            do {
                let json = try JSONDecoder().decode([CityModel].self, from: data)
                return .success(json)
            } catch {
                return .failure(.invalidData)
            }

        case let .failure(error):
            return .failure(error)
        }
    }
}
