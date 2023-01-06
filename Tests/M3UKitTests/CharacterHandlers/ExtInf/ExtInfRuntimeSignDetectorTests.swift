//
//  ExtInfRuntimeSignDetectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 05.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtInfRuntimeSignDetectorTests: XCTestCase {
    private var sut: ExtInfRuntimeSignDetector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = ItemsCollector()
        self.sut = ExtInfRuntimeSignDetector(collector: collector)
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
    
    func testFeed_minus_returnsExtInfRuntimeCollector() throws {
        let char: Character = "-"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfRuntimeCollector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_minus_appendsCharacter() throws {
        let char: Character = "-"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_number_returnsExtInfRuntimeCollector() throws {
        let char: Character = "1"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfRuntimeCollector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
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
    
    func testFeed_notNumberOrNewLine_returnsExtInfKeyStartDetector() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ExtInfKeyStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_notNumberOrNewLine_appendsCharacter() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    

}
