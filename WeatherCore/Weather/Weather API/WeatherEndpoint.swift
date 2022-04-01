//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

public enum WeatherEndpoint {
    case getByName(name: String)
    case getByGeo(lat: Double, lon: Double)

    public func url(baseURL: URL, key: String) -> URL {
        switch self {
        case let .getByName(name):
            return baseURL.appendingPathComponent("/v1/forecast.json")
                .appendQuery("key", value: key)
                .appendQuery("q", value: name)
                .appendQuery("days", value: "1")

        case let .getByGeo(lat, lon):
            return baseURL.appendingPathComponent("/v1/forecast.json")
                .appendQuery("key", value: key)
                .appendQuery("q", value: "\(lat),\(lon)")
                .appendQuery("days", value: "1")
        }
    }
}
