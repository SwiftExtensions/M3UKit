//
//  M3UPlaylistLineTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 17.02.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistLineTests: XCTestCase {
    var sut: M3UPlaylistLine!

    override func tearDownWithError() throws {
        self.sut = nil
    }

    
}

// MARK: - isExtInf tests

extension M3UPlaylistLineTests {
    func test_isExtInf_notExtInf_returnsFalse() throws {
        self.sut = .extM3U
        XCTAssertFalse(self.sut.isExtInf)
        self.sut = .extGrp(group: "Test")
        XCTAssertFalse(self.sut.isExtInf)
        self.sut = .extGrp
        XCTAssertFalse(self.sut.isExtInf)
        self.sut = .resource(path: "Test")
        XCTAssertFalse(self.sut.isExtInf)
        self.sut = .unknownTag(name: "Test_name", value: "Test_value")
        XCTAssertFalse(self.sut.isExtInf)
    }
    
    func test_isExtInf_extInf_returnsTrue() throws {
        self.sut = .extInf
        XCTAssertTrue(self.sut.isExtInf)
        self.sut = .extInf(runtime: -1, title: "Test")
        XCTAssertTrue(self.sut.isExtInf)
    }
    
    
}

// MARK: - setRuntime(_:) tests

extension M3UPlaylistLineTests {
    func test_setRuntime_invalidLine_throws() throws {
        self.sut = .extM3U
        let expectedError = M3UPlaylistLine.Error.runtimeNotFound(line: .extM3U)
        
        XCTAssertThrowsError(try self.sut.setRuntime("-1")) { error in
            XCTAssertEqual(error as! M3UPlaylistLine.Error, expectedError)
        }
    }
    
    func test_setRuntime_setsRuntime() throws {
        let runtime: TimeInterval = 123
        let expectedLine = M3UPlaylistLine.extInf(runtime: runtime, title: "")
        self.sut = .extInf
        try! self.sut.setRuntime(String(runtime))
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    

}

// MARK: - complete(value:) tests

extension M3UPlaylistLineTests {
    func test_complete_invalidLine_throws() throws {
        self.sut = .extM3U
        let expectedError = M3UPlaylistLine.Error.invalidCompletionCall(line: .extM3U)
        
        XCTAssertThrowsError(try self.sut.complete(value: "Test")) { error in
            XCTAssertEqual(error as! M3UPlaylistLine.Error, expectedError)
        }
    }
    
    func test_complete_extInf_setsValue() throws {
        let runtime: TimeInterval = -1
        let title = "Test"
        let expectedLine = M3UPlaylistLine.extInf(runtime: runtime, title: title)
        
        self.sut = M3UPlaylistLine.extInf(runtime: runtime, title: "")
        try! self.sut.complete(value: title)
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    
    func test_complete_extGrp_setsValue() throws {
        let group = "Test"
        let expectedLine = M3UPlaylistLine.extGrp(group: group)
        
        self.sut = M3UPlaylistLine.extGrp
        try! self.sut.complete(value: group)
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    
    func test_complete_unknownTag_setsValue() throws {
        let name = "Test Name"
        let value = "Test Vame"
        let expectedLine = M3UPlaylistLine.unknownTag(name: name, value: value)
        
        self.sut = M3UPlaylistLine.unknownTag(name: name, value: "")
        try! self.sut.complete(value: value)
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    

}

// MARK: - init(tag:) tests

extension M3UPlaylistLineTests {
    func test_initTag_unknownTag_createsCorrectLine() {
        let tag = "Invalid"
        self.sut = M3UPlaylistLine(tag: tag)
        let expectedLine = M3UPlaylistLine.unknownTag(name: tag, value: "")
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    
    func test_initTag_validTag_createsCorrectLine() {
        var tag = M3UExtTag.extM3U.rawValue
        self.sut = M3UPlaylistLine(tag: tag)
        var expectedLine = M3UPlaylistLine.extM3U
        
        XCTAssertEqual(self.sut, expectedLine)
        
        tag = M3UExtTag.extInf.rawValue
        self.sut = M3UPlaylistLine(tag: tag)
        expectedLine = .extInf
        
        XCTAssertEqual(self.sut, expectedLine)
        
        tag = M3UExtTag.extGrp.rawValue
        self.sut = M3UPlaylistLine(tag: tag)
        expectedLine = .extGrp
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    

}

// MARK: - init(line:) tests

extension M3UPlaylistLineTests {
    func test_initLine_invalidTag_createsCorrectLine() {
        let line = "Some resource"
        self.sut = M3UPlaylistLine(line: line)
        let expectedLine = M3UPlaylistLine.resource(path: line)
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    
    func test_initLine_validTag_createsCorrectLine() {
        var tag = M3UExtTag.extM3U.rawValue
        self.sut = M3UPlaylistLine(line: tag)
        var expectedLine = M3UPlaylistLine.extM3U
        
        XCTAssertEqual(self.sut, expectedLine)
        
        tag = M3UExtTag.extInf.rawValue
        self.sut = M3UPlaylistLine(line: tag)
        expectedLine = .extInf
        
        XCTAssertEqual(self.sut, expectedLine)
        
        tag = M3UExtTag.extGrp.rawValue
        self.sut = M3UPlaylistLine(line: tag)
        expectedLine = .extGrp
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    

}
