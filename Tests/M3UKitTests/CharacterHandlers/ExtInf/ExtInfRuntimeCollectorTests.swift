//
//  ExtInfRuntimeCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 05.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtInfRuntimeCollectorTests: XCTestCase {
    private var sut: ExtInfRuntimeCollector!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = ExtInfRuntimeCollector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.collector = nil
        
        try super.tearDownWithError()
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
    
    func testFeed_newline_returnsLineStartDetector() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is LineStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_newline_charactersIsOnlySign_savesTitle() throws {
        self.collector.characters = "-"
        let char: Character = "\n"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.keys.count, 1)
        XCTAssertEqual(self.collector.keys[0], .title)
    }
    
    func testFeed_newline_charactersIsNumber_savesRuntime() throws {
        self.collector.characters = "1"
        let char: Character = "\n"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.keys.count, 1)
        XCTAssertEqual(self.collector.keys[0], .runtime)
    }
    
    func testFeed_notANumber_charactersIsOnlySign_returnsExtInfTitleCollector() throws {
        self.collector.characters = "-"
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfTitleCollector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_notANumber_charactersIsOnlySign_appendsCharacter() throws {
        self.collector.characters = "-"
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_notANumber_charactersIsNumber_returnsExtInfKeyStartDetector() throws {
        self.collector.characters = "1"
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfKeyStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_notANumber_charactersIsNumber_savesRuntime() throws {
        self.collector.characters = "1"
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.keys.count, 1)
        XCTAssertEqual(self.collector.keys[0], .runtime)
    }
    
    func testFeed_notASeparator_charactersIsNumber_appendsCharacter() throws {
        self.collector.characters = "1"
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_separator_charactersIsNumber_notAppendsCharacter() throws {
        self.collector.characters = "1"
        let char: Character = ","
        _ = self.sut.feed(char)
        
        XCTAssertNotEqual(self.sut.collector.characters.last, char)
    }
    

}
