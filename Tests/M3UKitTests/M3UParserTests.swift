//
//  M3UParserTests.swift
//  M3UKiteTests
//
//  Created by Александр Алгашев on 07.02.2022.
//

import XCTest
@testable import M3UKit

class M3UParserTests: XCTestCase {
    var sut: M3UParser!

    override func setUpWithError() throws {
        self.sut = M3UParser()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_parseString_emptyString_throws() throws {
        let expectedError = M3UParser.Error.contentNotFound
        var actualError: Error? = nil
        do {
            _ = try self.sut.parse(string: "")
        } catch {
            actualError = error
        }
        
        XCTAssertNotNil(actualError)
        XCTAssertEqual(expectedError, actualError as? M3UParser.Error)
    }
    
    func test_parseString_whiteSpacesAndNewLinesString_throws() throws {
        let expectedError = M3UParser.Error.contentNotFound
        var actualError: Error? = nil
        do {
            _ = try self.sut.parse(string: " \n")
        } catch {
            actualError = error
        }
        
        XCTAssertNotNil(actualError)
        XCTAssertEqual(expectedError, actualError as? M3UParser.Error)
    }
    
    func test_parseString_invalidM3UString_throws() throws {
        let expectedError = M3UParser.Error.m3uPlaylistIsNotRecognized
        var actualError: Error? = nil
        do {
            _ = try self.sut.parse(string: "INVALID M3U")
        } catch {
            actualError = error
        }
        
        XCTAssertNotNil(actualError)
        XCTAssertEqual(expectedError, actualError as? M3UParser.Error)
    }
    
    func test_parseString_validM3U_createsCorrectValues() throws {
        let playlist = try self.sut.parse(string: .M3UPlaylist.demo)
        
        XCTAssertEqual(playlist.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(playlist.items, M3UDemoPlaylist.itemsExample)
    }
    
    func test_parseString_invalidTagInM3U_createsCorrectValues() throws {
        let playlist = try self.sut.parse(string: .M3UPlaylist.demoWithInvalidTag)
        
        XCTAssertEqual(playlist.lines, M3UDemoPlaylist.linesInvalidTagExample)
        XCTAssertEqual(playlist.items, M3UDemoPlaylist.itemsExample)
    }
    
    func test_parseData_createsCorrectValues() throws {
        let playlist = try self.sut.parse(data: String.M3UPlaylist.demo.utf8EncodingData)
        
        XCTAssertEqual(playlist.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(playlist.items, M3UDemoPlaylist.itemsExample)
    }

//    func test_performance_parseChars() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            _ = self.sut.parse(string: String.M3UPlaylist.freeiptv)
//        }
//    }
//
//    func test_performance_parseStandart() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            _ = String.M3UPlaylist.freeiptv.split(whereSeparator: \.isNewline)
//        }
//    }

}
