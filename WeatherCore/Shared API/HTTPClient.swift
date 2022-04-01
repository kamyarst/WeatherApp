//
//  HTTPClient.swift
//  WeatherApp
//
//  Created by Kamyar Sehati on 3/21/22.
//

import Foundation

public typealias HTTPResult<T> = Result<T, Error>

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @discardableResult
    func get(from url: URL) async -> HTTPResult<(Data, HTTPURLResponse)>
}

public enum HTTPError: Error {
    case connectivity
    case invalidData
    case unexpected
}
