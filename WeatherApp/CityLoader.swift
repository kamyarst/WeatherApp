//
//  CityLoader.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

protocol CityLoader {
    func load(by name: String) async -> HTTPResult<CityModel>
    func load(lat: Double, lon: Double) async -> HTTPResult<CityModel>
}

