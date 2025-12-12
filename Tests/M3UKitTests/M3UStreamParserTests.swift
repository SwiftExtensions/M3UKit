import XCTest
@testable import M3UKit

final class M3UStreamParserTests: XCTestCase {
    private var sut: M3UStreamParser!

    override func setUpWithError() throws {
        try super.setUpWithError()

        self.sut = M3UStreamParser()
    }

    override func tearDownWithError() throws {
        self.sut = nil

        try super.tearDownWithError()
    }

    func testFinish_demoPlaylist_returnsCorrectItems() throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }

        String.M3UPlaylist.demo.forEach { char in
            self.sut.feed(char)
        }

        self.sut.finish()
        let items = try self.sut.result.get()
        let actualItems = items.compactMap { $0 as? M3UItem }

        XCTAssertTrue(items[0] is M3UHeader)
        XCTAssertEqual(actualItems, expectedItems)
    }

    func testInit_resultIsFeedNotCalled() {
        XCTAssertEqual(self.sut.result.failure as? M3UStreamParser.StateError, .feedNotCalled)
    }

    func testAfterFeed_resultIsFinishNotCalled() {
        self.sut.feed("#")
        XCTAssertEqual(self.sut.result.failure as? M3UStreamParser.StateError, .finishNotCalled)
    }

    func testFinish_withoutFeed_resultIsFeedNotCalled() {
        self.sut.finish()
        XCTAssertEqual(self.sut.result.failure as? M3UStreamParser.StateError, .feedNotCalled)
    }

    func testFinish_onlyWhitespacesAndNewlines_resultIsContentNotFound() {
        "\n  \n\t\n".forEach { char in
            self.sut.feed(char)
        }

        self.sut.finish()
        XCTAssertEqual(self.sut.result.failure as? M3UParser.Error, .contentNotFound)
    }

    func testFinish_malformedPlaylist_resultIsMalformedM3UPlaylist() {
        "just some text".forEach { char in
            self.sut.feed(char)
        }

        self.sut.finish()
        XCTAssertEqual(self.sut.result.failure as? M3UParser.Error, .malformedM3UPlaylist)
    }

    func testReset_allowsParsingAgain() throws {
        String.M3UPlaylist.demo.forEach { char in
            self.sut.feed(char)
        }
        self.sut.finish()
        _ = try self.sut.result.get()

        self.sut.reset()

        String.M3UPlaylist.demo.forEach { char in
            self.sut.feed(char)
        }

        self.sut.finish()
        let items = try self.sut.result.get()
        XCTAssertFalse(items.isEmpty)
        XCTAssertTrue(items[0] is M3UHeader)
    }
}
