//
//  M3UPlaylistTests.swift
//  M3UKiteTests
//
//  Created by Александр Алгашев on 15.02.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistTests: XCTestCase {
    var sut: M3UPlaylist!

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_initLines_invalidLines_throws() throws {
        let expectedError = M3UParser.Error.invalidM3UPlaylist
        var actualError: Error? = nil
        do {
            _ = try M3UPlaylist(lines: M3UDemoPlaylist.invalidLinesExample)
        } catch {
            actualError = error
        }
        
        XCTAssertNotNil(actualError)
        XCTAssertEqual(expectedError, actualError as? M3UParser.Error)
    }
    
    func test_initLines_validLines_createsCorrectItems() throws {
        self.sut = try M3UPlaylist(lines: M3UDemoPlaylist.linesExample)
        
        XCTAssertEqual(self.sut.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(self.sut.items, M3UDemoPlaylist.itemsExample)
    }
    

}
