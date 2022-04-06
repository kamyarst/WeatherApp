// swiftlint:disable force_unwrapping
//
//  HTTPClientSpy.swift
//  WeatherAppTests
//
//  Created by Kamyar on 3/28/22.
//  Copyright © 2022 Kamyar Sehati. All rights reserved.
//

import Foundation
import WeatherCore

class HTTPClientSpy: HTTPClient {

    private var completions = [(url: URL, result: Result<(Data, HTTPURLResponse), Error>)]()

    var requestedURLs: [URL] {
        self.completions.map { $0.url }
    }

    func get(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
        let result = self.completions.last!.result
        switch result {
        case let .success(success):
            return success

        case let .failure(error):
            throw error
        }
    }

    func setURL(_ url: URL = anyURL()) {

        self.completions.append((url, .failure(HTTPError.connectivity)))
    }

    func setError(_ error: HTTPError, at index: Int = 0) {

        self.completions[index].result = .failure(error)
    }

    func setResponse(_ code: Int, data: Data, at index: Int = 0) {

        let response = HTTPURLResponse(url: completions[index].url, statusCode: code, httpVersion: nil,
                                       headerFields: nil)!
        self.completions[index].result = .success((data, response))
    }
}
