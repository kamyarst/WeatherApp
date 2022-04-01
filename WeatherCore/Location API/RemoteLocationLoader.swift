//
//  RemoteLocationLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

public final class RemoteLocationLoader: LocationLoader {

    private let client: HTTPClient
    private var url: URL

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public func load() async -> LocationResult<[LocationModel]> {

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
