// swiftlint:disable force_unwrapping
//
//  LoadLocationFromRemoteUseCaseTests.swift
//  WeatherAppTests
//
//  Created by Kamyar Sehati on 3/21/22.
//

@testable import WeatherCore
import XCTest

final class LoadLocationFromRemoteUseCaseTests: XCTestCase {

    func test_load_requestFromURL() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = await sut.load()

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestFromURL() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        client.setURL(url)
        _ = await sut.load()
        client.setURL(url)
        _ = await sut.load()

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliverErrorOnClientIssue() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        await self.expect(sut, completeWith: .failure(HTTPError.connectivity)) {
            client.setURL(url)
            client.setError(.connectivity)
        }
    }

    func test_load_deliverErrorOnNon200() async {
        let url = anyURL()
        let (sut, client) = self.makeSUT(url: url)

        let codes = [199, 201, 300, 400, 500]
        for (index, code) in codes.enumerated() {
            let json = self.makeItemJson([])
            await self.expect(sut, completeWith: .failure(HTTPError.invalidData)) {
                client.setURL(url)
                client.setResponse(code, data: json, at: index)
            }
        }
    }

    func test_load_deliverErrorOn200InvalidData() async {
        let (sut, client) = self.makeSUT()

        let data = Data("Invalid json".utf8)
        await self.expect(sut, completeWith: .failure(HTTPError.invalidData)) {
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

        let item1 = self.makeItem(id: 1, name: "Location Name", region: nil, country: nil, latitude: 1,
                                  longitude: 1, url: anyURL())

        let item2 = self.makeItem(id: 2, name: "Tehran", region: "Tehran", country: "Iran", latitude: 2,
                                  longitude: 2, url: anyURL())

        let jsonObjects = [item1.json, item2.json]

        await self.expect(sut, completeWith: .success([item1.model, item2.model])) {
            let json = makeItemJson(jsonObjects)
            client.setURL()
            client.setResponse(200, data: json)
        }
    }

    // MARK: - Helper class

    // swiftlint:disable function_parameter_count

    private func makeSUT(url: URL = anyURL())
        -> (sut: RemoteLocationLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteLocationLoader(client: client, url: url)
        trackMemoryLeak(sut)
        trackMemoryLeak(client)
        return (sut, client)
    }

    private func makeItem(id: Int, name: String, region: String?, country: String?, latitude: Double,
                          longitude: Double, url: URL) -> (model: LocationModel, json: [String: Any]) {

        let item = LocationModel(id: id, name: name, region: region, country: country, latitude: latitude,
                                 longitude: longitude, url: url)
        let json = ["id": item.id as Any,
                    "name": item.name,
                    "region": item.region as Any,
                    "country": item.country as Any,
                    "lat": item.latitude,
                    "lon": item.longitude,
                    "url": item.url?.absoluteString as Any].compactMapValues { $0 }
        return (item, json)
    }

    private func makeItemJson(_ items: [[String: Any]]) -> Data {
        let data = try? JSONSerialization.data(withJSONObject: items,
                                               options: [.fragmentsAllowed, .withoutEscapingSlashes])
        XCTAssertNotNil(data)
        return data ?? Data()
    }

    private func expect(_ sut: RemoteLocationLoader, completeWith expectedResult: HTTPResult<[LocationModel]>,
                        file: StaticString = #filePath, line: UInt = #line,
                        when action: () -> Void) async {

        action()
        let receivedResult = await sut.load()

        switch (receivedResult, expectedResult) {
        case let (.success(receivedItems), .success(expectedItems)):
            XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)

        case let (.failure(receivedError as HTTPError), .failure(expectedError as HTTPError)):
            XCTAssertEqual(receivedError, expectedError, file: file, line: line)

        default:
            XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
        }
    }
}
