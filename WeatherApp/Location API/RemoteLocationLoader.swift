//
//  RemoteLocationLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

final public class RemoteLocationLoader: LocationLoader {

    private let client: HTTPClient
    private var url: URL

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public func load(by name: String) async -> LocationResult<[LocationModel]> {
        self.url = URL(string: self.url.absoluteString + "q=\(name)")!
        return await self.load()
    }

    public func load(lat: Double, lon: Double) async -> LocationResult<[LocationModel]> {
        await self.load()
    }

    func load() async -> LocationResult<[LocationModel]> {

        let result = await self.client.get(from: self.url)
        switch result {
        case let .success((data, response)):

            if response.statusCode == 200,
               let json = try? JSONDecoder().decode([LocationModel].self, from: data) {
                return .success(json)
            } else {
                return .failure(HTTPError.invalidData)
            }

        case let .failure(error):
            return .failure(error)
        }
    }
}
