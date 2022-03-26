//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

public struct LocationModel: Equatable {
    let id: Int
    let name: String
    let region: String?
    let country: String?
    let latitude, longitude: Double
    let url: URL
}

// MARK: Codable

extension LocationModel: Codable {

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case region
        case country
        case latitude = "lat"
        case longitude = "lon"
        case url
    }
}
