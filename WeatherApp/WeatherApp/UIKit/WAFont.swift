//
//  WAFont.swift
//  WeatherApp
//
//  Created by Kamyar on 4/3/22.
//

import UIKit

private let textStyleDictionary: [UIFont.TextStyle: CGFloat] = [.largeTitle: 34,
                                                                .title1: 28,
                                                                .title2: 22,
                                                                .title3: 20,
                                                                .headline: 17,
                                                                .body: 17,
                                                                .callout: 16,
                                                                .subheadline: 15,
                                                                .footnote: 13,
                                                                .caption1: 12,
                                                                .caption2: 11]

enum WAFont {

    static func dynamicFont(_ fontWeight: UIFont.Weight,
                            _ textStyle: UIFont.TextStyle) -> UIFont {

        guard let size = textStyleDictionary[textStyle] else { fatalError() }
        let font = UIFont.systemFont(ofSize: size, weight: fontWeight)
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
    }

    static func fixedFont(_ fontWeight: UIFont.Weight,
                          _ size: CGFloat) -> UIFont {

        UIFont.systemFont(ofSize: size, weight: fontWeight)
    }
}
