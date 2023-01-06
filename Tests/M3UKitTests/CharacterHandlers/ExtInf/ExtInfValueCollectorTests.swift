//
//  ExtInfValueCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtInfValueCollectorTests: XCTestCase {
    private var sut: ExtInfValueCollector!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = ExtInfValueCollector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.collector = nil
        
        try super.tearDownWithError()
    }

    func testFeed_quote_returnsExtInfKeyStartDetector() throws {
        let char: Character = "\""
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfKeyStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_quote_savesValue() throws {
        let value = "test"
        self.collector.value = value
        let char: Character = "\""
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.values.count, 1)
        XCTAssertEqual(self.collector.values[0], value)
    }
    
    func testFeed_newline_returnsLineStartDetector() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is LineStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_newline_savesValue() throws {
        let value = "test"
        self.collector.value = value
        let char: Character = "\n"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.values.count, 1)
        XCTAssertEqual(self.collector.values[0], value)
    }
    
    func testFeed_notQuoteOrNewline_returnsNil() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_notQuoteOrNewline_appendsCharacter() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_notQuoteOrNewline_appendsCharacterToValue() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.value.last, char)
    }
    

}
