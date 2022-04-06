//
//  Endpoint.swift
//  WeatherCore
//
//  Created by Kamyar on 4/6/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var apiKey: String { get }
    var url: URL { get }
}

extension Endpoint {
    var baseURL: URL { URL(string: "https://api.weatherapi.com")! }
    var apiKey: String { "66a6dc4a010e4e91919132456222103" }
}
