// swiftlint:disable force_unwrapping
//
//  SharedTestsHelpers.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

func anyNSError() -> NSError {
    NSError(domain: "any error", code: 1)
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    Data("any data".utf8)
}

extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}

func anyKey() -> String {
    "66a6dc4a010e4e91919132456222101" // This key is invalid at weatherapi.com
}
