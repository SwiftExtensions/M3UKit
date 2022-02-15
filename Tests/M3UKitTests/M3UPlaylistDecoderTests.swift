//
//  M3UPlaylistDecoderTests.swift
//  M3UKiteTests
//
//  Created by Александр Алгашев on 07.02.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistDecoderTests: XCTestCase {
    var sut: M3UPlaylistDecoder!

    override func setUpWithError() throws {
        self.sut = M3UPlaylistDecoder()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_parsePlaylist_createsCorrectValues() throws {
        let playlist = self.sut.decode(string: .M3UPlaylist.demo)
        
        XCTAssertEqual(playlist.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(playlist.items, M3UDemoPlaylist.itemsExample)
    }
    
    func test_parseData_createsCorrectValues() throws {
        let playlist = self.sut.decode(data: String.M3UPlaylist.demo.utf8EncodingData)
        
        XCTAssertEqual(playlist.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(playlist.items, M3UDemoPlaylist.itemsExample)
    }

//    func test_performance_parseChars() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            self.sut.decode(playlist: M3UDemoPlaylist.example)
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
