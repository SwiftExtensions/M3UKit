//
//  M3UParserTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 05.01.2023.
//

import XCTest
@testable import M3UKit

final class M3UParserTests: XCTestCase {
    private var sut: M3UParser!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.sut = M3UParser()
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func testParse_demoPlaylist_returnsCorrectItems() throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }
        
        let items = try! self.sut.parse(string: .M3UPlaylist.demo)
        let actualItems = items.compactMap { $0 as? M3UItem }
        
        XCTAssertTrue(items[0] is M3UHeader)
        XCTAssertEqual(actualItems, expectedItems)
    }
    
    func testParse_demoWithCustomKeys_returnsCorrectItems() throws {
        let expectedItems = SamplePlaylist.demoWithCustomKeys.compactMap { $0 as? M3UItem }
        
        let items = try! self.sut.parse(string: .M3UPlaylist.demoWithCustomKeys)
        let actualItems = items.compactMap { $0 as? M3UItem }
        
        XCTAssertTrue(items[0] is M3UHeader)
        XCTAssertEqual(actualItems, expectedItems)
    }
    
    func testParse_demoWithUnknownDirective_returnsCorrectItems() throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }
        
        let items = try! self.sut.parse(string: .M3UPlaylist.demoWithUnknownDirective)
        let actualItems = items.compactMap { $0 as? M3UItem }
        
        XCTAssertTrue(items[0] is M3UHeader)
        XCTAssertEqual(actualItems, expectedItems)
    }
    
    func testParse_freeIPTVPlaylist_returnsCorrectItems() throws {
        let items = try! self.sut.parse(string: .M3UPlaylist.freeiptv)
        let actualItems = items.compactMap { $0 as? M3UItem }
        
        XCTAssertEqual(actualItems.count, 768)
        XCTAssertEqual(actualItems.filter({ $0[.group] != nil }).count, 767)
    }

    func testPerformanceFreeIPTVPlaylist() throws {
        self.measure {
            _ = try! self.sut.parse(string: .M3UPlaylist.freeiptv)
        }
    }

}
