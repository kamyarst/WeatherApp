// swiftlint:disable force_unwrapping nesting
//  URLSessionHTTPClientTests.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/25/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

@testable import WeatherCore
import XCTest

class URLSessionHTTPClientTests: XCTestCase {

    override func tearDown() async throws {
        try await super.tearDown()

        URLProtocolStub.removeStub()
    }

    func test_getFromURL_performsGETRequestWithURL() async {
        let url = anyURL()

        URLProtocolStub.observeRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
        }
        _ = await self.makeSUT().get(from: url)
    }

    func test_getFromURL_failsOnRequestError() async {
        let requestError = anyNSError()

        let receivedError = await self.resultErrorFor((data: nil, response: nil, error: requestError))

        XCTAssertNotNil(receivedError)
    }

    func test_getFromURL_failsOnAllInvalidRepresentationCases() async {
        let result1 = await self.resultErrorFor((data: nil, response: nil, error: nil))
        XCTAssertNotNil(result1)
        let result2 = await self.resultErrorFor((data: nil, response: self.nonHTTPURLResponse(), error: nil))
        XCTAssertNotNil(result2)
        let result3 = await self.resultErrorFor((data: anyData(), response: nil, error: nil))
        XCTAssertNotNil(result3)
        let result4 = await self.resultErrorFor((data: anyData(), response: nil, error: anyNSError()))
        XCTAssertNotNil(result4)
        let result5 = await self
            .resultErrorFor((data: nil, response: self.nonHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(result5)
        let result6 = await self
            .resultErrorFor((data: nil, response: self.anyHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(result6)
        let result7 = await self
            .resultErrorFor((data: anyData(), response: self.nonHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(result7)
        let result8 = await self
            .resultErrorFor((data: anyData(), response: self.anyHTTPURLResponse(), error: anyNSError()))
        XCTAssertNotNil(result8)
        let result9 = await self
            .resultErrorFor((data: anyData(), response: self.nonHTTPURLResponse(), error: nil))
        XCTAssertNotNil(result9)
    }

    func test_getFromURL_succeedsOnHTTPURLResponseWithData() async {
        let data = anyData()
        let response = self.anyHTTPURLResponse()

        let receivedValues = await self.resultValuesFor((data: data, response: response, error: nil))

        XCTAssertEqual(receivedValues?.data, data)
        XCTAssertEqual(receivedValues?.response.url, response.url)
        XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
    }

    func test_getFromURL_succeedsWithEmptyDataOnHTTPURLResponseWithNilData() async {
        let response = self.anyHTTPURLResponse()

        let receivedValues = await self.resultValuesFor((data: nil, response: response, error: nil))

        let emptyData = Data()
        XCTAssertEqual(receivedValues?.data, emptyData)
        XCTAssertEqual(receivedValues?.response.url, response.url)
        XCTAssertEqual(receivedValues?.response.statusCode, response.statusCode)
    }

    // MARK: - Helpers

    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)

        let sut = URLSessionHTTPClient(session: session)
        trackMemoryLeak(sut, file: file, line: line)
        return sut
    }

    private func resultValuesFor(_ values: (data: Data?, response: URLResponse?, error: Error?),
                                 file: StaticString = #filePath,
                                 line: UInt = #line) async -> (data: Data, response: HTTPURLResponse)? {
        let result = await self.resultFor(values, file: file, line: line)

        switch result {
        case let .success((data, response)):
            return (data, response)

        default:
            XCTFail("Expected success, got \(result) instead", file: file, line: line)
            return nil
        }
    }

    private func resultErrorFor(_ values: (data: Data?, response: URLResponse?, error: Error?)? = nil,
                                taskHandler: () -> Void = { },
                                file: StaticString = #filePath,
                                line: UInt = #line) async -> Error? {
        let result = await self.resultFor(values, taskHandler: taskHandler, file: file, line: line)

        switch result {
        case let .failure(error):
            return error

        default:
            XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            return nil
        }
    }

    private func resultFor(_ values: (data: Data?, response: URLResponse?, error: Error?)?,
                           taskHandler: () -> Void = { },
                           file: StaticString = #filePath,
                           line: UInt = #line) async -> HTTPResult<(Data, HTTPURLResponse)> {
        values.map { URLProtocolStub.stub(data: $0, response: $1, error: $2) }

        let sut = self.makeSUT(file: file, line: line)
        taskHandler()
        let result = await sut.get(from: anyURL())
        return result
    }

    private func anyHTTPURLResponse() -> HTTPURLResponse {
        HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }

    private func nonHTTPURLResponse() -> URLResponse {
        URLResponse(url: anyURL(), mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
    }

    // MARK: - Helper

    final class URLProtocolStub: URLProtocol {
        private struct Stub {
            let data: Data?
            let response: URLResponse?
            let error: Error?
            let requestObserver: ((URLRequest) -> Void)?
        }

        private static var _stub: Stub?
        private static var stub: Stub? {
            get { queue.sync { _stub } }
            set { queue.sync { _stub = newValue } }
        }

        private static let queue = DispatchQueue(label: "URLProtocolStub.queue")

        static func stub(data: Data?, response: URLResponse?, error: Error?) {
            self.stub = Stub(data: data, response: response, error: error, requestObserver: nil)
        }

        static func observeRequests(observer: @escaping (URLRequest) -> Void) {
            self.stub = Stub(data: nil, response: nil, error: nil, requestObserver: observer)
        }

        static func removeStub() {
            self.stub = nil
        }

        override class func canInit(with _: URLRequest) -> Bool {
            true
        }

        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            request
        }

        override func startLoading() {
            guard let stub = URLProtocolStub.stub else { return }

            if let data = stub.data {
                client?.urlProtocol(self, didLoad: data)
            }

            if let response = stub.response {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            if let error = stub.error {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                client?.urlProtocolDidFinishLoading(self)
            }

            stub.requestObserver?(request)
        }

        override func stopLoading() { }
    }
}
