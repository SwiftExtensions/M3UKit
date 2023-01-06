//
//  CharactersCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 04.01.2023.
//

import XCTest
@testable import M3UKit

final class CharactersCollectorTests: XCTestCase {
    private var sut: CharactersCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = ItemsCollector()
        self.sut = CharactersCollector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func testFeed_newLine_returnsLineStartDetector() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is LineStartDetector)
        XCTAssertTrue(handler?.collector === self.sut.collector)
    }
    
    func testFeed_whitespace_returnsNil() throws {
        let char: Character = " "
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_whitespace_appendsCharacter() throws {
        let char: Character = " "
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    
    func testFeed_alphanumeric_returnsNil() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_alphanumeric_appendsCharacter() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    

}
