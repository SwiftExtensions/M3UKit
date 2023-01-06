//
//  DataTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class DataTests: XCTestCase {
    private var sut: Data!

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func test_utf8String_returnsCorrectString() throws {
        let string = "Test"
        let data = Data(string.utf8)
        
        XCTAssertEqual(data.utf8String, string)
    }
    

}
