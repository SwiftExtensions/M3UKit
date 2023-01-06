//
//  ExtGrpCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 04.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtGrpCollectorTests: XCTestCase {
    private var sut: ExtGrpCollector!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = ExtGrpCollector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.collector = nil
        
        try super.tearDownWithError()
    }

    func testFeed_newLine_returnsLineStartDetector() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is LineStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_newLine_savesGroup() throws {
        let char: Character = "\n"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.keys.count, 1)
        XCTAssertEqual(self.collector.keys[0], .group)
    }
    
    func testFeed_whitespace_returnsNilAndAppendCharacter() throws {
        let char: Character = " "
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_alphanumeric_returnsNilAndAppendCharacter() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    

}
