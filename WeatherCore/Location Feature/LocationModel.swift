//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

public struct LocationModel: Equatable {

    public let id: Int?
    public let name: String
    public let region: String?
    public let country: String?
    public let latitude, longitude: Double
    public let url: URL?
    public let localTimeEpoch: Int?
    public let localTime: String?

    public init(id: Int, name: String, region: String?, country: String?, latitude: Double, longitude: Double,
                url: URL, localTimeEpoch: Int? = nil, localTime: String? = nil) {
        self.id = id
        self.name = name
        self.region = region
        self.country = country
        self.localTimeEpoch = localTimeEpoch
        self.localTime = localTime
        self.latitude = latitude
        self.longitude = longitude
        self.url = url
    }
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
        case localTimeEpoch = "localtime_epoch"
        case localTime = "localtime"
    }
}
