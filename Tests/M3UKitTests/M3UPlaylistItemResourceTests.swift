//
//  M3UPlaylistItemResourceTests.swift
//  
//
//  Created by Александр Алгашев on 13.01.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistItemResourceTests: XCTestCase {
    var sut: M3UPlaylistItem.Resource!

    func test_initValidURLPath_createsCorrectResource() throws {
        let path = "http://example.com"
        let url = URL(string: path)
        let expectedResource = M3UPlaylistItem.Resource.url(url!)
        self.sut = M3UPlaylistItem.Resource(string: path)
        
        XCTAssertNotNil(url)
        XCTAssertEqual(self.sut, expectedResource)
    }
    
    func test_initInvalidURLPath_createsCorrectResource() throws {
        let path = "Not Valid URL"
        let expectedResource = M3UPlaylistItem.Resource.path(path)
        self.sut = M3UPlaylistItem.Resource(string: path)
        
        XCTAssertEqual(self.sut, expectedResource)
    }


}
