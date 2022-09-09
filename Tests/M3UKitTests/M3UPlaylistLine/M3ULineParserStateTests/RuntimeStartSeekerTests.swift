//
//  RuntimeStartSeekerTests.swift
//
//
//  Created by Александр Алгашев on 06.02.2022.
//

import XCTest
@testable import M3UKit

class RuntimeStartSeekerTests: XCTestCase {
    var sut: M3ULineParser.RuntimeStartSeeker!

    override func setUpWithError() throws {
        self.sut = M3ULineParser.RuntimeStartSeeker()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_init_setsCorrectValues() throws {
        XCTAssertFalse(self.sut.isAppendable)
        XCTAssertFalse(self.sut.isExtTag)
        XCTAssertFalse(self.sut.isRuntime)
        XCTAssertFalse(self.sut.isEndOfLine)
    }
    
    func test_feed_number_returnsCorrectState() {
        let state = self.sut.feed("1")
        XCTAssertNotNil(state as? M3ULineParser.RuntimeState)
        XCTAssertTrue(state.isAppendable)
        XCTAssertFalse(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertFalse(state.isEndOfLine)
    }
    
    func test_feed_minus_returnsCorrectState() {
        let state = self.sut.feed("-")
        XCTAssertNotNil(state as? M3ULineParser.RuntimeState)
        XCTAssertTrue(state.isAppendable)
        XCTAssertFalse(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertFalse(state.isEndOfLine)
    }
    
    func test_feed_space_returnsCorrectState() {
        let state = self.sut.feed(" ")
        XCTAssertNotNil(state as? M3ULineParser.RuntimeStartSeeker)
    }

    func test_feed_character_returnsCorrectState() {
        let state = self.sut.feed("h")
        XCTAssertNotNil(state as? M3ULineParser.EndOfLineSeeker)
        XCTAssertTrue(state.isAppendable)
        XCTAssertFalse(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertFalse(state.isEndOfLine)
    }


}