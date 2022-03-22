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
            let json = self.makeItemJson([])
            await self.expect(sut, completeWith: .failure(.invalidData)) {
                client.setURL(url)
                client.setResponse(code, data: json, at: index)
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
            let data = makeItemJson([])
            client.setURL()
            client.setResponse(200, data: data)
        }
    }

    func test_load_deliverItemsOn200() async {
        let (sut, client) = self.makeSUT()

        let item1 = self.makeItem(id: 1, name: "City Name", region: nil, country: nil, latitude: 1,
                                  longitude: 1, url: URL(string: "https://someUrl.com")!)

        let item2 = self.makeItem(id: 2, name: "Tehran", region: "Tehran", country: "Iran", latitude: 2,
                                  longitude: 2, url: URL(string: "https://someUrl.com")!)

        let jsonObjects = [item1.json, item2.json]

        await self.expect(sut, completeWith: .success([item1.model, item2.model])) {
            let json = makeItemJson(jsonObjects)
            client.setURL()
            client.setResponse(200, data: json)
        }
    }

    // MARK: - Helper class

    private func trackMemoryLeak(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {

        addTeardownBlock { [weak instance] () in
            XCTAssertNil(instance, "Memory leak check", file: file, line: line)
        }
    }

    private func makeSUT(url: URL = URL(string: "https://google.com")!)
        -> (sut: RemoteCityLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteCityLoader(client: client, url: url)
        trackMemoryLeak(sut)
        trackMemoryLeak(client)
        return (sut, client)
    }

    private func makeItem(id: Int, name: String, region: String?, country: String?, latitude: Double,
                          longitude: Double, url: URL) -> (model: CityModel, json: [String: Any]) {

        let item = CityModel(id: id, name: name, region: region, country: country, latitude: latitude,
                             longitude: longitude, url: url)
        let json = ["id": item.id,
                    "name": item.name,
                    "region": item.region as Any,
                    "country": item.country as Any,
                    "lat": item.latitude,
                    "lon": item.longitude,
                    "url": item.url.absoluteString].compactMapValues { $0 }
        return (item, json)
    }

    private func makeItemJson(_ items: [[String: Any]]) -> Data {
        try! JSONSerialization.data(withJSONObject: items, options: .fragmentsAllowed)
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
