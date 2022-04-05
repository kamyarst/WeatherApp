//
//  LocationLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

protocol LocationLoader {
    func load() async throws -> [LocationModel]
}
