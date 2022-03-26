//
//  URL.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/26/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation

extension URL {

    mutating func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        guard let url = urlComponents.url else { return absoluteURL }
        return url
    }
}
