//
//  M3UExtTagTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 17.02.2022.
//

import XCTest
@testable import M3UKit

final class M3UExtTagTests: XCTestCase {
    var sut: M3UExtTag!

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_buildLine_extM3U_createsCorrectLine() throws {
        self.sut = .extM3U
        let actualLine = self.sut.buildLine()
        let expectedLine: M3UPlaylistLine = .extM3U
        
        XCTAssertEqual(actualLine, expectedLine)
    }
    
    func test_buildLine_extInf_createsCorrectLine() throws {
        self.sut = .extInf
        let actualLine = self.sut.buildLine()
        let expectedLine: M3UPlaylistLine = .extInf
        
        XCTAssertEqual(actualLine, expectedLine)
    }
    
    func test_buildLine_extGrp_createsCorrectLine() throws {
        self.sut = .extGrp
        let actualLine = self.sut.buildLine()
        let expectedLine: M3UPlaylistLine = .extGrp
        
        XCTAssertEqual(actualLine, expectedLine)
    }


}
