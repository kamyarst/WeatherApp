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

extension XCTest {

    func XCTAssertThrowsError<T: Sendable>(_ expression: @autoclosure () async throws -> T,
                                           _ message: @autoclosure () -> String = "",
                                           file: StaticString = #filePath,
                                           line: UInt = #line,
                                           _ errorHandler: (_ error: Error) -> Void = { _ in }) async {
        do {
            _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }

    func XCTAssertNoThrowsError<T: Sendable>(_ expression: @autoclosure () async throws -> T,
                                             _ message: @autoclosure () -> String = "",
                                             file: StaticString = #filePath,
                                             line: UInt = #line,
                                             _ errorHandler: (_ error: Error) -> Void = { _ in }) async {
        do {
            _ = try await expression()
        } catch {
            XCTFail(error.localizedDescription, file: file, line: line)
            errorHandler(error)
        }
    }
}
