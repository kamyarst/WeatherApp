//
//  XCTestCase+trackForMemoryLeaks.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/21/22.
//

import XCTest

extension XCTestCase {
    func trackMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {

        addTeardownBlock { [weak instance] () in
            XCTAssertNil(instance, "Memory leak check", file: file, line: line)
        }
    }
}
