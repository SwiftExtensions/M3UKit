//
//  ExtInfKeyStartDetectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 05.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtInfKeyStartDetectorTests: XCTestCase {
    private var sut: ExtInfKeyStartDetector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = ItemsCollector()
        self.sut = ExtInfKeyStartDetector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
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
    
    func testFeed_isNotLetter_returnsExtInfTitleCollector() throws {
        let char: Character = "1"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfTitleCollector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_isNotLetter_appendsCharacter() throws {
        let char: Character = "1"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_comma_notAppendsCharacter() throws {
        let char: Character = ","
        _ = self.sut.feed(char)
        
        XCTAssertNotEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_letter_returnsExtInfKeyCollector() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfKeyCollector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_letter_appendsCharacter() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    

}
