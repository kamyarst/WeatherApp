//
//  WAConstant.swift
//  WeatherApp
//
//  Created by Kamyar on 4/2/22.
//

import UIKit

struct WAConstant {

    enum Margin: Int {
        /// 4
        case verySmall = 1
        /// 8
        case small = 2
        /// 12
        case medium = 3
        /// 16
        case standard = 4
        /// 20
        case big = 5
        /// 24
        case veryBig = 6

        var value: CGFloat {
            CGFloat(self.rawValue * 4)
        }
    }

    enum ControlHeight: Int {
        /// 24
        case verySmall = 6
        /// 40
        case small = 10
        /// 44
        case medium = 11
        /// 48
        case big = 12

        var value: CGFloat {
            CGFloat(self.rawValue * 4)
        }
    }
}
