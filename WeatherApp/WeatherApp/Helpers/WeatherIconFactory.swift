//
//  WeatherIconFactory.swift
//  WeatherApp
//
//  Created by Kamyar on 4/6/22.
//

import Foundation

/// This Factory maps servers icons to images of the Apple's SF Symbol
enum WeatherIconFactory {

    private static let mappedIcons: [Int: (day: String, night: String)] =
        [1000: ("sun.max.fill", "moon.fill"),
         1003: ("cloud.sun.fill", "cloud.moon.fill"),
         1006: ("cloud", "cloud"),
         1009: ("cloud.fill", "cloud.fill"),
         1030: ("cloud.fog.fill", "cloud.fog"),
         1063: ("cloud.sun.rain.fill", "cloud.moon.rain.fill"),
         1066: ("cloud.snow.fill", "cloud.snow"),
         1069: ("cloud.sleet.fill", "cloud.sleet"),
         1072: ("cloud.drizzle.fill", "cloud.drizzle"),
         1087: ("cloud.sun.bolt.fill", "cloud.moon.bolt.fill"),
         1114: ("wind.snow", "wind.snow"),
         1117: ("wind.snow", "wind.snow"),
         1135: ("cloud.fog.fill", "cloud.fog"),
         1147: ("cloud.fog.fill", "cloud.fog"),
         1150: ("cloud.drizzle.fill", "cloud.drizzle"),
         1153: ("cloud.drizzle.fill", "cloud.drizzle"),
         1168: ("cloud.drizzle.fill", "cloud.drizzle"),
         1171: ("cloud.drizzle.fill", "cloud.drizzle"),
         1180: ("cloud.sun.rain.fill", "cloud.moon.rain.fill"),
         1183: ("cloud.rain.fill", "cloud.rain"),
         1186: ("cloud.sun.rain.fill", "cloud.moon.rain.fill"),
         1189: ("cloud.rain.fill", "cloud.rain"),
         1192: ("cloud.sun.rain.fill", "cloud.moon.rain.fill"),
         1195: ("cloud.heavyrain.fill", "cloud.heavyrain"),
         1198: ("cloud.rain.fill", "cloud.rain"),
         1201: ("cloud.rain.fill", "cloud.rain"),
         1204: ("cloud.sleet.fill", "cloud.sleet"),
         1207: ("cloud.sleet.fill", "cloud.sleet"),
         1210: ("cloud.snow.fill", "cloud.snow"),
         1213: ("cloud.snow.fill", "cloud.snow"),
         1216: ("cloud.snow.fill", "cloud.snow"),
         1219: ("cloud.snow.fill", "cloud.snow"),
         1222: ("cloud.snow.fill", "cloud.snow"),
         1225: ("cloud.snow.fill", "cloud.snow"),
         1237: ("cloud.hail.fill", "cloud.hail"),
         1240: ("cloud.sun.rain", "cloud.moon.rain"),
         1243: ("cloud.sun.rain", "cloud.moon.rain"),
         1246: ("cloud.sun.rain.fill", "cloud.moon.rain.fill"),
         1249: ("cloud.sleet.fill", "cloud.sleet"),
         1252: ("cloud.sleet.fill", "cloud.sleet"),
         1255: ("cloud.snow.fill", "cloud.snow"),
         1258: ("cloud.snow.fill", "cloud.snow"),
         1261: ("cloud.hail.fill", "cloud.hail"),
         1264: ("cloud.hail.fill", "cloud.hail"),
         1273: ("cloud.sun.bolt.fill", "cloud.moon.bolt.fill"),
         1276: ("cloud.bolt.fill", "cloud.bolt"),
         1279: ("cloud.snow.fill", "cloud.snow"),
         1282: ("cloud.snow.fill", "cloud.snow")]

    static func get(code: Int, isDay: Int) -> String? {
        let icon = self.mappedIcons[code]
        let isDay = isDay == 1
        return isDay ? icon?.day : icon?.night
    }
}
