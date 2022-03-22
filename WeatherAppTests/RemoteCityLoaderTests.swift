//
//  RemoteCityLoaderTests.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/21/22.
//

@testable import WeatherApp
import XCTest

class RemoteCityLoaderTests: XCTestCase {

    func test_load_requestFromURL() async {
        let url = URL(string: "https://google.com")!
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = await sut.load()

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestFromURL() async {
        let url = URL(string: "https://google.com")!
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = await sut.load()
        client.setURL(url)
        _ = await sut.load()

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliverErrorOnClientIssue() async {
        let url = URL(string: "https://google.com")!
        let (sut, client) = self.makeSUT(url: url)

        await self.expect(sut, completeWith: .failure(.connectivity)) {
            client.setURL(url)
            client.setError(.connectivity)
        }
    }

    func test_load_deliverErrorOnNon200() async {
        let url = URL(string: "https://google.com")!
        let (sut, client) = self.makeSUT(url: url)

        let codes = [199, 201, 300, 400, 500]
        for (index, code) in codes.enumerated() {

            await self.expect(sut, completeWith: .failure(.invalidData)) {
                client.setURL(url)
                client.setResponse(code, data: Data(), at: index)
            }
        }
    }

    func test_load_deliverErrorOn200InvalidData() async {
        let (sut, client) = self.makeSUT()

        let data = Data("Invalid json".utf8)
        await self.expect(sut, completeWith: .failure(.invalidData)) {
            client.setURL()
            client.setResponse(200, data: data)
        }
    }

    func test_load_deliversNoItem200EmptyJson() async {
        let (sut, client) = self.makeSUT()

        await self.expect(sut, completeWith: .success([])) {
            let data = Data("[]".utf8)
            client.setURL()
            client.setResponse(200, data: data)
        }
    }

    // MARK: - Helper class

    private func makeSUT(url: URL = URL(string: "https://google.com")!)
        -> (sut: RemoteCityLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteCityLoader(client: client, url: url)
        return (sut, client)
    }

    private func expect(_ sut: RemoteCityLoader, completeWith result: HTTPResult<[CityModel]>,
                        file: StaticString = #filePath, line: UInt = #line,
                        when action: () -> Void) async {

        var capturedResult = [HTTPResult<[CityModel]>]()

        action()
        let result = await sut.load()
        capturedResult.append(result)
        XCTAssertEqual(capturedResult, [result], file: file, line: line)
    }

    private class HTTPClientSpy: HTTPClient {

        private var completions = [(url: URL, result: HTTPResult<(Data, HTTPURLResponse)>)]()

        var requestedURLs: [URL] {
            self.completions.map { $0.url }
        }

        func get(get url: URL) async -> HTTPResult<(Data, HTTPURLResponse)> {
            self.completions.last!.result
        }

        func setURL(_ url: URL = URL(string: "https://google.com")!) {

            self.completions.append((url, .failure(.connectivity)))
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
}
