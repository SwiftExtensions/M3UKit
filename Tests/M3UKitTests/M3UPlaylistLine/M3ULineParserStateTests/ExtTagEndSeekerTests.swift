//
//  ExtTagEndSeekerTests.swift
//
//
//  Created by Александр Алгашев on 06.02.2022.
//

import XCTest
@testable import M3UKit

class ExtTagEndSeekerTests: XCTestCase {
    var sut: M3ULineParser.ExtTagEndSeeker!

    override func setUpWithError() throws {
        self.sut = M3ULineParser.ExtTagEndSeeker()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_init_setsCorrectValues() throws {
        XCTAssertTrue(self.sut.isAppendable)
        XCTAssertFalse(self.sut.isExtTag)
        XCTAssertFalse(self.sut.isRuntime)
        XCTAssertFalse(self.sut.isEndOfLine)
    }
    
    func test_feed_newLine_returnsCorrectState() {
        let state = self.sut.feed("\n")
        XCTAssertNotNil(state as? M3ULineParser.EndOfLineState)
        XCTAssertFalse(state.isAppendable)
        XCTAssertTrue(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertTrue(state.isEndOfLine)
    }
    
    func test_feed_column_returnsCorrectState() {
        let state = self.sut.feed(":")
        XCTAssertNotNil(state as? M3ULineParser.EndOfLineSeeker)
        XCTAssertTrue(state.isAppendable)
        XCTAssertTrue(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertFalse(state.isEndOfLine)
    }

    func test_feed_character_returnsCorrectState() {
        let state = self.sut.feed("h")
        XCTAssertNotNil(state as? M3ULineParser.ExtTagEndSeeker)
        XCTAssertTrue(state.isAppendable)
        XCTAssertFalse(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertFalse(state.isEndOfLine)
    }


}
