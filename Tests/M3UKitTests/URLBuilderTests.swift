import XCTest
@testable import M3UKit

final class URLBuilderTests: XCTestCase {
    func test_build_validURLString_returnsURL() throws {
        let urlString = "https://example.com/path?q=1"

        let builder = URLBuilder(string: urlString)
        let url = try builder.build()

        XCTAssertEqual(url.absoluteString, urlString)
    }

    func test_build_invalidURLString_throwsURLErrorBadURL() throws {
        let urlString = "INVALID URL"
        var actualError: Error?

        do {
            _ = try URLBuilder(string: urlString).build()
        } catch {
            actualError = error
        }

        XCTAssertNotNil(actualError)
        XCTAssertTrue(actualError is URLError)
        XCTAssertEqual(actualError?.localizedDescription, "Malformed URL: \'INVALID URL\'.")
    }
}
