//
//  Date.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import Foundation

extension Date {

    var time: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }

    var dayOfWeekText: String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }

    /// Initialize a Date object with a string
    /// - Parameter string: It should use "yyyy-MM-dd HH:mm" format
    init(string: String) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        self = formatter.date(from: string) ?? Date()
    }
}
