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
    
    func test_setRuntime_invalidLine_throws() {
        self.sut = .extM3U
        let expectedError = M3UPlaylistLine.Error.runtimeNotFound(line: .extM3U)
        
        XCTAssertThrowsError(try self.sut.setRuntime("-1")) { error in
            XCTAssertEqual(error as? M3UPlaylistLine.Error, expectedError)
        }
    }
    
    func test_setRuntime_setsRuntime() {
        let runtime: TimeInterval = 123
        let expectedLine = M3UPlaylistLine.extInf(runtime: runtime, title: "")
        self.sut = .extInf
        try? self.sut.setRuntime(String(runtime))
        
        XCTAssertEqual(self.sut, expectedLine)
    }
    

}
