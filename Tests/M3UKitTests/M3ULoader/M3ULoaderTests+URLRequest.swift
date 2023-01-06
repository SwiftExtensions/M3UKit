//
//  M3ULoaderTests+URLRequest.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

extension M3ULoaderTests {
    func test_loadRequestError_callsFailture() throws {
        let expectedError = URLError(.timedOut) as NSError
        let result = MockURLSession.Result(data: nil, response: nil, error: expectedError)
        let urlString = "https://example.com/" + #function.description
        MockURLSession.results[urlString] = result
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let expextation = expectation(description: #function)
        var isLoadCalled = false
        
        let dataTask = self.sut.load(with: request) { response in
            isLoadCalled = true
            
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)

            let actualError = response.failure as NSError?
            XCTAssertNotNil(actualError)
            XCTAssertEqual(actualError?.domain, expectedError.domain)
            XCTAssertEqual(actualError?.code, expectedError.code)

            MockURLSession.results[urlString] = nil
            
            expextation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(isLoadCalled)
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask.originalRequest?.url, url)
    }

    func test_loadRequest_callsSuccess() throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let expextation = expectation(description: #function)
        var isLoadCalled = false
        
        let dataTask = self.sut.load(with: request) { response in
            isLoadCalled = true
            
            XCTAssertNotNil(response.success)
            XCTAssertNil(response.failure)
            
            let actualItems = response.success?.compactMap { $0 as? M3UItem }
            
            XCTAssertEqual(actualItems, expectedItems)

            MockURLSession.results[urlString] = nil
            
            expextation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(isLoadCalled)
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask.originalRequest?.url, url)
    }
    
    func test_loadRequest_callsInCorrectDispatchQueue() {
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)

        let targetQueue = DispatchQueue(label: #function)
        
        let expextation = expectation(description: #function)
        var isLoadCalled = false
        
        let dataTask = self.sut.load(with: request, dispatchQueue: targetQueue) { response in
            dispatchPrecondition(condition: .onQueue(targetQueue))
            DispatchQueue.main.async {
                isLoadCalled = true
                
                XCTAssertNotNil(response.success)
                XCTAssertNil(response.failure)

                MockURLSession.results[urlString] = nil
                
                expextation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(isLoadCalled)
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask.originalRequest?.url, url)
    }


}
