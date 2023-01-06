//
//  LineStartDetectorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 03.01.2023.
//

import XCTest
@testable import M3UKit

final class LineStartDetectorTests: XCTestCase {
    private var sut: LineStartDetector!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        let collector = ItemsCollector()
        self.sut = LineStartDetector(collector: collector)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }
    
    func testInit_resetsCollector() throws {
        let collector = MockItemsCollector()
        self.sut = LineStartDetector(collector: collector)
        
        XCTAssertEqual(collector.resets, 1)
    }

    func testFeed_newLine_returnsNil() throws {
        let char: Character = "\n"
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_whitespace_returnsNil() throws {
        let char: Character = " "
        let handler = self.sut.feed(char)
        
        XCTAssertNil(handler)
    }
    
    func testFeed_hash_returnsDirectiveCollector() throws {
        let char: Character = "#"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is DirectiveCollector)
    }
    
    func testFeed_hash_startsCollectDirective() throws {
        let char: Character = "#"
        let handler = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
        XCTAssertTrue(self.sut.collector === handler?.collector)
    }
    
    func testFeed_alphanumeric_returnsResourceCollector() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertNotNil(handler)
        XCTAssertTrue(handler is ResourceCollector)
    }
    
    func testFeed_alphanumeric_startsCollectResource() throws {
        let char: Character = "a"
        let handler = self.sut.feed(char)
        
        XCTAssertEqual(self.sut.collector.characters.last, char)
        XCTAssertTrue(self.sut.collector === handler?.collector)
    }


}
