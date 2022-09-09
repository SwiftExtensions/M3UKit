//
//  EndOfLineSeekerTests.swift
//
//
//  Created by Александр Алгашев on 06.02.2022.
//

import XCTest
@testable import M3UKit

class EndOfLineSeekerTests: XCTestCase {
    var sut: M3ULineParser.EndOfLineSeeker!

    func test_init_setsCorrectValues() throws {
        let isAppendable = true
        let isExtTag = false
        let isRuntime = false
        self.sut = M3ULineParser.EndOfLineSeeker(isAppendable: isAppendable, isExtTag: isExtTag, isRuntime: isRuntime)
        XCTAssertEqual(self.sut.isAppendable, isAppendable)
        XCTAssertEqual(self.sut.isExtTag, isExtTag)
        XCTAssertEqual(self.sut.isRuntime, isRuntime)
        XCTAssertFalse(self.sut.isEndOfLine)
    }
    
    func test_feed_newLine_returnsCorrectState() {
        self.sut = .default
        let state = self.sut.feed("\n")
        XCTAssertNotNil(state as? M3ULineParser.EndOfLineState)
        XCTAssertFalse(state.isAppendable)
        XCTAssertFalse(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertTrue(state.isEndOfLine)
    }

    func test_feed_character_returnsCorrectState() {
        self.sut = .default
        let state = self.sut.feed("h")
        XCTAssertNotNil(state as? M3ULineParser.EndOfLineSeeker)
        XCTAssertTrue(state.isAppendable)
        XCTAssertFalse(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertFalse(state.isEndOfLine)
    }


}
