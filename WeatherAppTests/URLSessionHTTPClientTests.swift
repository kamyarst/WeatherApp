//
//  URLSessionHTTPClientTests.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/25/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

@testable import WeatherApp
import XCTest

protocol HTTPSession {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask
}

protocol HTTPSessionTask {
    func resume()
}

class URLSessionHTTPClient {

    private var session: HTTPSession
    init(session: HTTPSession) {
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

    func test() async {
        let url = URL(string: "http://google.com")!
        let session = HTTPSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, task: task)
        let result = await sut.get(from: url)

        XCTAssertEqual(task.resumeCallCount, 1)
    }

    func test_getFromURL_failsOnRequestError() async {

        let url = URL(string: "http://google.com")!
        let session = HTTPSessionSpy()
        let error = NSError(domain: "any", code: 1)
        let sut = URLSessionHTTPClient(session: session)
        session.stub(url: url, error: error)
        let result = await sut.get(from: url)

        switch result {
        case let .failure(receivedError as NSError):
            XCTAssertEqual(receivedError, error)

        default:
            XCTFail("Unexpected")
        }
    }

    // MARK: - Helpers

    private class HTTPSessionSpy: HTTPSession {
        private struct Stub {
            let task: HTTPSessionTask
            let error: Error?
        }

        private var stubs = [URL: Stub]()

        func stub(url: URL, task: HTTPSessionTask = FakeURLSessionDataTask(), error: Error? = nil) {
            self.stubs[url] = Stub(task: task, error: error)
        }

        func dataTask(with url: URL,
                      completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> HTTPSessionTask {
            guard let stub = stubs[url] else {
                fatalError()
            }
            completionHandler(nil, nil, stub.error)
            return stub.task
        }
    }

    private class FakeURLSessionDataTask: HTTPSessionTask {
        func resume() { }
    }

    private class URLSessionDataTaskSpy: HTTPSessionTask {
        var resumeCallCount = 0

        func resume() {
            self.resumeCallCount += 1
        }
    }
}
