//
//  EndOfLineStateTests.swift
//
//
//  Created by Александр Алгашев on 06.02.2022.
//

import XCTest
@testable import M3UKit

class EndOfLineStateTests: XCTestCase {
    var sut: M3UPlaylistLineDecoder.EndOfLineState!

    func test_init_setsCorrectValues() throws {
        let isExtTag = false
        self.sut = M3UPlaylistLineDecoder.EndOfLineState(isExtTag: isExtTag)
        XCTAssertFalse(self.sut.isAppendable)
        XCTAssertEqual(self.sut.isExtTag, isExtTag)
        XCTAssertFalse(self.sut.isRuntime)
        XCTAssertTrue(self.sut.isEndOfLine)
    }


}
