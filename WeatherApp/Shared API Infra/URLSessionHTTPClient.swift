//
//  URLSessionHTTPClient.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    public func get(from url: URL) async -> HTTPResult<(Data, HTTPURLResponse)> {
        await withCheckedContinuation { continuation in
            self.session.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(returning: .failure(error))
                } else if let data = data, let response = response as? HTTPURLResponse {
                    continuation.resume(returning: .success((data, response)))
                } else {
                    continuation.resume(returning: .failure(HTTPError.unexpected))
                }
            }.resume()
        }
    }

    private class UnexpectedValuesRepresentation: Error { }

    private struct URLSessionTaskWrapper: HTTPClientTask {
        let wrapped: URLSessionTask

        func cancel() {
            self.wrapped.cancel()
        }
    }
}
