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
         1003: ("cloud.sun.fill", ""),
         1006: ("cloud", ""),
         1009: ("cloud.fill", ""),
         1030: ("cloud.fog.fill", ""),
         1063: ("cloud.sun.rain.fill", ""),
         1066: ("", ""),
         1069: ("", ""),
         1072: ("", ""),
         1087: ("", ""),
         1114: ("", ""),
         1117: ("", ""),
         1135: ("", ""),
         1147: ("", ""),
         1150: ("", ""),
         1153: ("", ""),
         1168: ("", ""),
         1171: ("", ""),
         1180: ("", ""),
         1183: ("", ""),
         1186: ("", ""),
         1189: ("", ""),
         1192: ("cloud.sun.rain.fill",
                "cloud.moon.rain.fill"),
         1195: ("cloud.heavyrain.fill",
                "cloud.heavyrain"),
         1198: ("", ""),
         1201: ("", ""),
         1204: ("cloud.sleet.fill",
                "cloud.sleet"),
         1207: ("cloud.sleet.fill",
                "cloud.sleet"),
         1210: ("cloud.snow.fill",
                "cloud.snow"),
         1213: ("cloud.snow.fill",
                "cloud.snow"),
         1216: ("cloud.snow.fill",
                "cloud.snow"),
         1219: ("cloud.snow.fill",
                "cloud.snow"),
         1222: ("cloud.snow.fill",
                "cloud.snow"),
         1225: ("cloud.snow.fill",
                "cloud.snow"),
         1237: ("", ""),
         1240: ("cloud.sun.rain",
                "cloud.moon.rain"),
         1243: ("cloud.sun.rain",
                "cloud.moon.rain"),
         1246: ("cloud.sun.rain.fill",
                "cloud.moon.rain.fill"),
         1249: ("cloud.sleet.fill",
                "cloud.sleet"),
         1252: ("", ""),
         1255: ("", ""),
         1258: ("", ""),
         1261: ("", ""),
         1264: ("", ""),
         1273: ("cloud.sun.bolt.fill",
                "cloud.moon.bolt.fill"),
         1276: ("cloud.bolt.fill",
                "cloud.bolt"),
         1279: ("", ""),
         1282: ("", "")]

    static func get(code: Int, isDay: Int) -> String? {
        let icon = self.mappedIcons[code]
        let isDay = isDay == 1
        return isDay ? icon?.day : icon?.night
    }
}
