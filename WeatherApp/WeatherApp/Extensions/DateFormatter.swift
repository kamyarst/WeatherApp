//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import Foundation

public extension DateFormatter {

    static let standard: DateFormatter = {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter
    }()
}
