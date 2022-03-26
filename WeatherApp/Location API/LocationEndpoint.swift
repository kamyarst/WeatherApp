//
//  LocationEndpoint.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/26/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

public enum LocationEndpoint {
    case getByName(name: String)
    case getByGeo(lat: Double, lon: Double)

    public func url(baseURL: URL, key: String) -> URL {
        switch self {
        case let .getByName(name):
            return baseURL.appendingPathComponent("/v1/search.json")
                .appending("key", value: key)
                .appending("q", value: name)

        case let .getByGeo(lat, lon):
            return baseURL.appendingPathComponent("/v1/search.json")
                .appending("key", value: key)
                .appending("q", value: "\(lat),\(lon)")
        }
    }
}
