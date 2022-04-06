//
//  WeatherEndpoint.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

public enum WeatherEndpoint: Endpoint {
    case getByName(name: String)
    case getByGeo(lat: Double, lon: Double)

    var url: URL {
        switch self {
        case let .getByName(name):
            return baseURL.appendingPathComponent("/v1/forecast.json")
                .appendQuery("key", value: apiKey)
                .appendQuery("q", value: name)
                .appendQuery("days", value: "3")

        case let .getByGeo(lat, lon):
            return baseURL.appendingPathComponent("/v1/forecast.json")
                .appendQuery("key", value: apiKey)
                .appendQuery("q", value: "\(lat),\(lon)")
                .appendQuery("days", value: "3")
        }
    }
}
