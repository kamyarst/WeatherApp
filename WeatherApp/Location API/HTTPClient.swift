//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/22/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

enum HTTPError: Error {
    case connectivity
    case invalidData
}

typealias HTTPResult<T> = Result<T, Error>

protocol HTTPClient {
    func get(get url: URL) async -> HTTPResult<(Data, HTTPURLResponse)>
}
