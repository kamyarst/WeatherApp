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

    func test_load_deliverItemsOn200() async {
        let (sut, client) = self.makeSUT()

        let item1 = CityModel(id: 1, name: "City Name", region: nil, country: nil, latitude: 1, longitude: 1,
                              url: URL(string: "https://someUrl.com")!)

        let item2 = CityModel(id: 2, name: "Tehran", region: "Tehran", country: "Iran", latitude: 2,
                              longitude: 2, url: URL(string: "https://someUrl.com")!)

        let jsonObjects = self.createCites(cities: [item1, item2])

        await self.expect(sut, completeWith: .success([item1, item2])) {
            let json = try! JSONSerialization.data(withJSONObject: jsonObjects, options: .fragmentsAllowed)
            client.setURL()
            client.setResponse(200, data: json)
        }
    }

    // MARK: - Helper class

    private func makeSUT(url: URL = URL(string: "https://google.com")!)
        -> (sut: RemoteCityLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteCityLoader(client: client, url: url)
        return (sut, client)
    }

    private func createCites(cities: [CityModel]) -> [[String: Any]] {

        cities.compactMap { item in
            ["id": item.id,
             "name": item.name,
             "region": item.region as Any,
             "country": item.country as Any,
             "lat": item.latitude,
             "lon": item.longitude,
             "url": item.url.absoluteString] as [String: Any]
        }
    }

    private func expect(_ sut: RemoteCityLoader, completeWith result: HTTPResult<[CityModel]>,
                        file: StaticString = #filePath, line: UInt = #line,
                        when action: () -> Void) async {

        var capturedResult = [HTTPResult<[CityModel]>]()

        action()
        let loader = await sut.load()
        capturedResult.append(loader)
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