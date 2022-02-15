//
//  M3UPlaylistParserTests.swift
//  M3UKiteTests
//
//  Created by Александр Алгашев on 07.02.2022.
//

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

    func test_parsePlaylist_createsCorrectValues() throws {
        let playlist = self.sut.parse(string: .M3UPlaylist.demo)
        
        XCTAssertEqual(playlist.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(playlist.items, M3UDemoPlaylist.itemsExample)
    }
    
    func test_parseData_createsCorrectValues() throws {
        let playlist = self.sut.parse(data: String.M3UPlaylist.demo.utf8EncodingData)
        
        XCTAssertEqual(playlist.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(playlist.items, M3UDemoPlaylist.itemsExample)
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
