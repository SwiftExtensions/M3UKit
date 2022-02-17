//
//  M3UPlaylistLineErrorTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 17.02.2022.
//

import XCTest
@testable import M3UKit

final class M3UPlaylistLineErrorTests: XCTestCase {
    var sut: M3UPlaylistLine.Error!

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_runtimeNotFound_createsCorrectDescription() throws {
        self.sut = .runtimeNotFound(line: .extM3U)
        let expectedError = #"The line does not support "runtime" parameter: extM3U."#
        
        XCTAssertEqual(self.sut.localizedDescription, expectedError)
    }
    
    func test_invalidCompletionCall_createsCorrectDescription() throws {
        self.sut = .invalidCompletionCall(line: .extM3U)
        let expectedError = #"The line does not support "complete(value:)" method: extM3U."#
        
        XCTAssertEqual(self.sut.localizedDescription, expectedError)
    }


}
