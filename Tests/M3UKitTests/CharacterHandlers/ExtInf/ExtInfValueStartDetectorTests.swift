//
//  ExtInfValueStartDetectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtInfValueStartDetectorTests: XCTestCase {
    private var sut: ExtInfValueStartDetector!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = ExtInfValueStartDetector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.collector = nil
        
        try super.tearDownWithError()
    }

    func testFeed_whitespace_returnsNil() throws {
        let char: Character = " "
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_newline_returnsLineStartDetector() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is LineStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_newline_savesTitle() throws {
        self.collector.characters = "-"
        let char: Character = "\n"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.keys.count, 1)
        XCTAssertEqual(self.collector.keys[0], .title)
    }
    
    func testFeed_notWhitespaceOrNewline_returnsExtInfValueCollector() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfValueCollector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_notWhitespaceOrNewline_appendsCharacter() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_notWhitespaceOrNewline_appendsCharacterToValue() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.value.last, char)
    }
    
    func testFeed_quote_notAppendsCharacterToValue() throws {
        let char: Character = "\""
        _ = self.sut.feed(char)
        
        XCTAssertNotEqual(self.sut.collector.value.last, char)
    }


}
