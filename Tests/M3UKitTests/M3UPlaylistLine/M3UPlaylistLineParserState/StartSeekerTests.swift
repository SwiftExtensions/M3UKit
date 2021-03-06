//
//  StartSeekerTests.swift
//
//
//  Created by Александр Алгашев on 06.02.2022.
//

import XCTest
@testable import M3UKit

class StartSeekerTests: XCTestCase {
    var sut: M3UPlaylistLineDecoder.StartSeeker!

    override func setUpWithError() throws {
        self.sut = M3UPlaylistLineDecoder.StartSeeker()
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
    
    func test_feed_hash_returnsCorrectState() {
        let state = self.sut.feed("#")
        XCTAssertNotNil(state as? M3UPlaylistLineDecoder.ExtTagEndSeeker)
    }
    
    func test_feed_character_returnsCorrectState() {
        let state = self.sut.feed("h")
        XCTAssertNotNil(state as? M3UPlaylistLineDecoder.EndOfLineSeeker)
        XCTAssertTrue(state.isAppendable)
        XCTAssertFalse(state.isExtTag)
        XCTAssertFalse(state.isRuntime)
        XCTAssertFalse(state.isEndOfLine)
    }
    
    func test_feed_newLine_returnsCorrectState() {
        let state = self.sut.feed("\n")
        XCTAssertNotNil(state as? M3UPlaylistLineDecoder.StartSeeker)
    }


}
