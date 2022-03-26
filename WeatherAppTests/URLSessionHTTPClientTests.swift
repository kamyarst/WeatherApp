// swiftlint:disable force_unwrapping nesting
//  URLSessionHTTPClientTests.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/25/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

@testable import WeatherApp
import XCTest

class URLSessionHTTPClient {

    private var session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }

    func get(from url: URL) async -> HTTPResult<Any> {
        await withCheckedContinuation { continuation in
            self.session.dataTask(with: url) { data, _, error in
                if let error = error {
                    continuation.resume(returning: .failure(error))
                } else {
                    continuation.resume(returning: .success(data))
                }
            }.resume()
        }
    }
}

class URLSessionHTTPClientTests: XCTestCase {

    override func setUp() async throws {
        try await super.setUp()
        URLProtocolSub.register()
    }

    override func tearDown() async throws {
        try await super.tearDown()
        URLProtocolSub.unregister()
    }

    func test_getFromURL_failsOnRequestError() async {

        let url = URL(string: "http://google.com")!
        let error = NSError(domain: "some error", code: 1)
        URLProtocolSub.stub(url: url, error: error)

        let sut = URLSessionHTTPClient()
        let result = await sut.get(from: url)

        switch result {
        case let .failure(receivedError as NSError):
            XCTAssertEqual(receivedError, error)

        default:
            XCTFail("Unexpected")
        }
    }

    // MARK: - Helpers

    private class URLProtocolSub: URLProtocol {
        private struct Stub {
            let error: Error?
        }

        private static var stubs = [URL: Stub]()

        static func stub(url: URL, error: Error? = nil) {
            self.stubs[url] = Stub(error: error)
        }

        static func register() {
            URLProtocol.registerClass(URLProtocolSub.self)
        }

        static func unregister() {
            URLProtocol.unregisterClass(URLProtocolSub.self)
            self.stubs = [:]
        }

        override class func canInit(with request: URLRequest) -> Bool {
            guard let url = request.url else { return false }

            return self.stubs[url] != nil
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            request
        }

        override func startLoading() {
            guard let url = request.url, let stub = URLProtocolSub.stubs[url] else { return }
            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            }

            client?.urlProtocolDidFinishLoading(self)
        }

        override func stopLoading() { }
    }
}
