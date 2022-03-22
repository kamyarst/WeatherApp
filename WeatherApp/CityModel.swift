//
//  CityModel.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

struct CityModel: Equatable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat, lon: Double
    let url: String
}
