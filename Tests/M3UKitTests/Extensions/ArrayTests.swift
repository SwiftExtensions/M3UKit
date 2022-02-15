//
//  ArrayTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 13.01.2022.
//

import XCTest
@testable import M3UKit

class ArrayTests: XCTestCase {
    var sut: [M3UPlaylistLine]!

    override func tearDownWithError() throws {
        self.sut = nil
    }
    
    func test_buildItems_createsCorrectItems() throws {
        self.sut = M3UDemoPlaylist.linesExample
        let items = self.sut.buildItems()
        
        XCTAssertEqual(items, M3UDemoPlaylist.itemsExample)
    }
    

}
