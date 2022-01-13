import XCTest
@testable import M3UKit

class EndOfLineStateTests: XCTestCase {
    var sut: M3UPlaylistLineParser.EndOfLineState!

    func test_init_setsCorrectValues() throws {
        let isExtTag = false
        self.sut = M3UPlaylistLineParser.EndOfLineState(isExtTag: isExtTag)
        XCTAssertFalse(self.sut.isAppendable)
        XCTAssertEqual(self.sut.isExtTag, isExtTag)
        XCTAssertFalse(self.sut.isRuntime)
        XCTAssertTrue(self.sut.isEndOfLine)
    }


}
