//
//  NetworkerTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class NetworkerTests: XCTestCase {
    private var sut: Networker!
    private var mockSession: URLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.mockSession = URLSession.mockSession(protocolClass: MockURLSession.self)
        self.sut = Networker(session: self.mockSession)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        self.mockSession = nil
        
        try super.tearDownWithError()
    }

    func test_run_returnsDataTaskAndRunsRequest() throws {
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let expextation = expectation(description: #function)
        var isLoadCalled = false
        
        let dataTask = self.sut.run(with: request) { response in
            isLoadCalled = true

            XCTAssertNotNil(response)
            
            MockURLSession.results[urlString] = nil
            
            expextation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(isLoadCalled)
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask.originalRequest?.url, url)
    }
    

}
