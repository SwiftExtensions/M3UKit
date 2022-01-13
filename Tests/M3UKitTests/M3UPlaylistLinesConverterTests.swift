//
//  M3UPlaylistLinesConverterTests.swift
//  
//
//  Created by Александр Алгашев on 13.01.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistLinesConverterTests: XCTestCase {
    var sut: M3UPlaylistLinesConverter!

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_init_setsLines() throws {
        self.sut = M3UPlaylistLinesConverter(lines: M3UDemoPlaylist.linesExample)
        
        XCTAssertEqual(self.sut.lines, M3UDemoPlaylist.linesExample)
    }
    
    func test_buildItems_createsCorrectItems() throws {
        self.sut = M3UPlaylistLinesConverter(lines: M3UDemoPlaylist.linesExample)
        let items = self.sut.buildItems()
        
        XCTAssertEqual(items, M3UDemoPlaylist.itemsExample)
    }



}
