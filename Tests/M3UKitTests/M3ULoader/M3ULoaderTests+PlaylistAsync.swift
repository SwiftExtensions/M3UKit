import XCTest
@testable import M3UKit

@available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, *)
extension M3ULoaderTests {
    func test_playlistForRequest_callsSuccess() async throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result
        defer { MockURLSession.results[urlString] = nil }

        let url = URL(string: urlString)!
        let request = URLRequest(url: url)

        let playlist = try await self.sut.playlist(for: request)
        let actualItems = playlist.compactMap { $0 as? M3UItem }

        XCTAssertEqual(actualItems, expectedItems)
    }

    func test_playlistForRequest_nonHTTPResponse_throwsBadServerResponse() async {
        let urlString = "https://example.com/" + #function.description
        let url = URL(string: urlString)!
        let response = URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)
        let result = MockURLSession.Result(data: Data(), response: response, error: nil)
        MockURLSession.results[urlString] = result
        defer { MockURLSession.results[urlString] = nil }

        let request = URLRequest(url: url)

        do {
            _ = try await self.sut.playlist(for: request)
            XCTFail("Expected to throw")
        } catch {
            let actualError = error as NSError
            XCTAssertEqual(actualError.domain, URLError.errorDomain)
            XCTAssertEqual(actualError.code, URLError.badServerResponse.rawValue)
        }
    }

    func test_playlistForRequest_non2xxStatusCode_throwsBadServerResponse() async {
        let urlString = "https://example.com/" + #function.description
        let url = URL(string: urlString)!
        let response = HTTPURLResponse(urlString: urlString, statusCode: 404)!
        let result = MockURLSession.Result(data: Data(), response: response, error: nil)
        MockURLSession.results[urlString] = result
        defer { MockURLSession.results[urlString] = nil }

        let request = URLRequest(url: url)

        do {
            _ = try await self.sut.playlist(for: request)
            XCTFail("Expected to throw")
        } catch {
            let actualError = error as NSError
            XCTAssertEqual(actualError.domain, URLError.errorDomain)
            XCTAssertEqual(actualError.code, URLError.badServerResponse.rawValue)
            XCTAssertTrue(actualError.localizedDescription.contains("Invalid status code: 404"))
        }
    }

    func test_playlistForURL_callsSuccess() async throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result
        defer { MockURLSession.results[urlString] = nil }

        let url = URL(string: urlString)!

        let playlist = try await self.sut.playlist(from: url)
        let actualItems = playlist.compactMap { $0 as? M3UItem }

        XCTAssertEqual(actualItems, expectedItems)
    }

    func test_playlistForURLString_callsSuccess() async throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result
        defer { MockURLSession.results[urlString] = nil }

        let playlist = try await self.sut.playlist(from: urlString)
        let actualItems = playlist.compactMap { $0 as? M3UItem }

        XCTAssertEqual(actualItems, expectedItems)
    }

    func test_playlistForURLString_invalidURL_throwsBadURL() async {
        let invalidURLString = "ht^tp://example.com"

        do {
            _ = try await self.sut.playlist(from: invalidURLString)
            XCTFail("Expected to throw")
        } catch {
            let actualError = error as NSError
            XCTAssertEqual(actualError.domain, URLError.errorDomain)
            XCTAssertEqual(actualError.code, URLError.badURL.rawValue)
            XCTAssertEqual(actualError.localizedDescription, "Malformed URL: '\(invalidURLString)'.")
        }
    }
}
