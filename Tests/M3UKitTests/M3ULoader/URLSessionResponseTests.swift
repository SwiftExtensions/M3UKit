//
//  URLSessionResponseTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class URLSessionResponseTests: XCTestCase {
    private var sut: URLSessionResponse!

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func test_handle_error_returnsError() throws {
        let expectedError = URLError(.timedOut) as NSError
        self.sut = URLSessionResponse(data: nil, metadata: nil, error: expectedError)
        
        let result = self.sut.handle()
        
        var actualData: Data?
        var actualError: NSError?
        do {
            actualData = try result.get()
        } catch {
            actualError = error as NSError
        }
        
        XCTAssertNil(actualData)
        XCTAssertNotNil(actualError)
        
        XCTAssertEqual(actualError?.domain, expectedError.domain)
        XCTAssertEqual(actualError?.code, expectedError.code)
    }
    
    func test_handle_data_returnsData() throws {
        let expectedData = Data()
        self.sut = URLSessionResponse(data: expectedData, metadata: nil, error: nil)
        
        let result = self.sut.handle()
        
        var actualData: Data?
        var actualError: NSError?
        do {
            actualData = try result.get()
        } catch {
            actualError = error as NSError
        }
        
        XCTAssertNotNil(actualData)
        XCTAssertNil(actualError)
        
        XCTAssertEqual(actualData, expectedData)
    }
    
    func test_handle_noDataOrError_returnsError() throws {
        let expectedError = URLError(.badServerResponse) as NSError
        self.sut = URLSessionResponse(data: nil, metadata: nil, error: nil)
        
        let result = self.sut.handle()
        
        var actualData: Data?
        var actualError: NSError?
        do {
            actualData = try result.get()
        } catch {
            actualError = error as NSError
        }
        
        XCTAssertNil(actualData)
        XCTAssertNotNil(actualError)
        
        XCTAssertEqual(actualError?.domain, expectedError.domain)
        XCTAssertEqual(actualError?.code, expectedError.code)
        XCTAssertEqual(actualError?.localizedDescription, "Unknown error.")
    }
    

}
