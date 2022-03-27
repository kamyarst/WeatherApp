//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

public struct LocationModel: Equatable {
    public let id: Int
    public let name: String
    public let region: String?
    public let country: String?
    public let latitude, longitude: Double
    public let url: URL
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
