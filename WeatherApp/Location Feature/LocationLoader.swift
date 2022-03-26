//
//  LocationLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

typealias LocationResult<T> = Result<T, Error>

protocol LocationLoader {
    func load(by name: String) async -> LocationResult<[LocationModel]>
    func load(lat: Double, lon: Double) async -> LocationResult<[LocationModel]>
}
