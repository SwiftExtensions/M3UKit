import XCTest
@testable import M3UKit

class M3UPlaylistParserTests: XCTestCase {
    var sut: M3UPlaylistParser!

    override func setUpWithError() throws {
        self.sut = M3UPlaylistParser()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_parse_createsCorrectLines() throws {
        self.sut.parse(playlist: M3UDemoPlaylist.example)
        print(self.sut.items)
        
        XCTAssertEqual(self.sut.lines, M3UDemoPlaylist.linesExample)
    }

//    func test_performance_parseChars() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            self.sut.parse(playlist: M3UDemoPlaylist.example)
//        }
//    }
//
//    func test_performance_parseStandart() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            _ = M3UDemoPlaylist.example.split(whereSeparator: \.isNewline)
//        }
//    }

}
