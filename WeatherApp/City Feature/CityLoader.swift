//
//  CityLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

typealias CityResult<T> = Result<T, Error>

protocol CityLoader {
    func load(by name: String) async -> CityResult<[CityModel]>
    func load(lat: Double, lon: Double) async -> CityResult<[CityModel]>
}
