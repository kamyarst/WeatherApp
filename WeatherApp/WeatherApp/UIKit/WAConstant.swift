//
//  WAConstant.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

struct WAConstant {

    enum Margin: Int {
        case verySmall = 1
        case small = 2
        case medium = 3
        case standard = 4
        case big = 5
        case veryBig = 6

        var value: CGFloat {
            CGFloat(self.rawValue * 4)
        }
    }

    enum ControlHeight: Int {
        case verySmall = 6
        case small = 10
        case medium = 11
        case big = 12

        var value: CGFloat {
            CGFloat(self.rawValue * 4)
        }
    }
}
