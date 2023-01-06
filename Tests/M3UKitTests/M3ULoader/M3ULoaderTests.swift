//
//  M3ULoaderTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class M3ULoaderTests: XCTestCase {
    var sut: M3ULoader!
    var mockSession: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.mockSession = URLSession.mockSession(protocolClass: MockURLSession.self)
        self.sut = M3ULoader(session: self.mockSession)
    }
    
    override func tearDownWithError() throws {
        self.sut = nil
        self.mockSession = nil
        
        try super.tearDownWithError()
    }

    
}
