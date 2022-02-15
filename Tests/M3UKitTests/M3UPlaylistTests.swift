//
//  M3UPlaylistTests.swift
//  M3UKiteTests
//
//  Created by Александр Алгашев on 15.02.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistTests: XCTestCase {
    var sut: M3UPlaylist!

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_init_createsCorrectItems() throws {
        self.sut = M3UPlaylist(lines: M3UDemoPlaylist.linesExample)
        
        XCTAssertEqual(self.sut.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(self.sut.items, M3UDemoPlaylist.itemsExample)
    }
    

}
