//
//  ExtInfTitleCollectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class ExtInfTitleCollectorTests: XCTestCase {
    private var sut: ExtInfTitleCollector!
    private var collector: MockItemsCollector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = MockItemsCollector()
        self.collector = collector
        self.sut = ExtInfTitleCollector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.collector = nil
        
        try super.tearDownWithError()
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
    
    func testFeed_notNewline_returnsNil() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_notNewline_appendsCharacter() throws {
        let char: Character = "a"
        _ = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
    }
    

}
