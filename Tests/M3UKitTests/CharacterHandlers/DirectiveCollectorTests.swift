//
//  DirectiveCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 03.01.2023.
//

import XCTest
@testable import M3UKit

final class DirectiveCollectorTests: XCTestCase {
    private var sut: DirectiveCollector!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = DirectiveCollector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func testFeed_newline_returnsLineStartDetector() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is LineStartDetector)
        XCTAssertTrue(self.sut.collector === handler?.collector)
    }
    
    func testFeed_newline_validDirective_saves() throws {
        self.collector.characters = "#EXTM3U"
        let char: Character = "\n"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.collector.directives.count, 1)
    }
    
    func testFeed_whitespace_returnsCharacterHandler() throws {
        let char: Character = " "
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(self.sut.collector === handler?.collector)
    }
    
    func testFeed_colon_returnsCharacterHandler() throws {
        let colon: Character = ":"
        let handler = self.sut.feed(colon)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(self.sut.collector === handler?.collector)
    }
    
    func testFeed_alphanumeric_returnsNil() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_alphanumeric_appendsToCollector() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    

}
