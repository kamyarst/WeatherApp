//
//  LocationEndpoint.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/26/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

public enum LocationEndpoint: Endpoint {
    case getByName(name: String)
    case getByGeo(lat: Double, lon: Double)

    var url: URL {
        switch self {
        case let .getByName(name):
            return baseURL.appendingPathComponent("/v1/search.json")
                .appendQuery("key", value: apiKey)
                .appendQuery("q", value: name)

        case let .getByGeo(lat, lon):
            return baseURL.appendingPathComponent("/v1/search.json")
                .appendQuery("key", value: apiKey)
                .appendQuery("q", value: "\(lat),\(lon)")
        }
    }
}

protocol Endpoint {
    var baseURL: URL { get }
    var apiKey: String { get }
    var url: URL { get }
}

extension Endpoint {
    var baseURL: URL { URL(string: "https://api.weatherapi.com")! }
    var apiKey: String { "66a6dc4a010e4e91919132456222103" }
}
