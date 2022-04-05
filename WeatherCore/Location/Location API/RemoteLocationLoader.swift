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

    public func load() async throws -> [LocationModel] {

        let result = try await self.client.get(from: self.url)
        if result.response.statusCode == 200,
           let json = try? JSONDecoder().decode([LocationModel].self, from: result.data) {
            return json
        } else {
            throw HTTPError.invalidData
        }
    }
}
