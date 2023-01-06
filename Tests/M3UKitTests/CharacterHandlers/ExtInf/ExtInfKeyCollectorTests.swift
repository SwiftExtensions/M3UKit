//
//  ExtInfKeyCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 05.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtInfKeyCollectorTests: XCTestCase {
    private var sut: ExtInfKeyCollector!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = ExtInfKeyCollector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.collector = nil
        
        try super.tearDownWithError()
    }

    func testFeed_letter_returnsNil() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_letter_appendsCharacter() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_dashOrUnderlining_returnsNil() throws {
        let char: Character = "-"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_dashOrUnderlining_appendsCharacter() throws {
        let char: Character = "-"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_number_returnsNil() throws {
        let char: Character = "1"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_number_appendsCharacter() throws {
        let char: Character = "1"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_equalSign_returnsExtInfValueStartDetector() throws {
        let char: Character = "="
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfValueStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_equalSign_appendsCharacter() throws {
        let char: Character = "="
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_equalSign_setsCharactersToKey() throws {
        let characters = "test"
        self.collector.characters = characters
        let char: Character = "="
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.key, characters)
    }
    
    func testFeed_whitespace_returnsExtInfKeyEndDetector() throws {
        let char: Character = " "
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfKeyEndDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_whitespace_appendsCharacter() throws {
        let char: Character = " "
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_newline_returnsLineStartDetector() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is LineStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_newline_savesTitle() throws {
        let char: Character = "\n"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.keys.count, 1)
        XCTAssertEqual(self.collector.keys[0], .title)
    }
    
    func testFeed_invalidCharacter_returnsExtInfTitleCollector() throws {
        let char: Character = "."
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfTitleCollector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_invalidCharacter_appendsCharacter() throws {
        let char: Character = "."
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    

}
