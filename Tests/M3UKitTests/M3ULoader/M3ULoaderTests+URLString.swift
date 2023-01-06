//
//  M3ULoaderTests+URLString.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

extension M3ULoaderTests {
    func test_loadURLString_invalidURL_throws() throws {
        let urlString = "INVALID URL"
        var dataTask: URLSessionDataTask?
        var actualError: Error?
        
        self.sut = M3ULoader()
        do {
            dataTask = try self.sut.load(with: urlString) { _ in }
        } catch {
            actualError = error
        }
        
        XCTAssertNil(dataTask)
        XCTAssertNotNil(actualError)
        XCTAssertTrue(actualError is URLError)
        XCTAssertEqual(actualError?.localizedDescription, "Malformed URL.")
    }
    
    func test_loadURLStringError_callsFailture() throws {
        let expectedError = URLError(.timedOut) as NSError
        let result = MockURLSession.Result(data: nil, response: nil, error: expectedError)
        let urlString = "https://example.com/" + #function.description
        MockURLSession.results[urlString] = result
        
        let expextation = expectation(description: #function)
        var isLoadCalled = false
        
        let dataTask = try self.sut.load(with: urlString) { response in
            isLoadCalled = true
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)
            
            let actualError = response.failure! as NSError
            XCTAssertEqual(actualError.domain, expectedError.domain)
            XCTAssertEqual(actualError.code, expectedError.code)
            
            MockURLSession.results[urlString] = nil
            
            expextation.fulfill()
        }
        
        waitForExpectations(timeout: 0.1)
        XCTAssertTrue(isLoadCalled)
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask.originalRequest?.url?.absoluteString, urlString)
    }
    
    func test_loadURLString_callsSuccess() throws {
        let expectedItems = SamplePlaylist.demo.compactMap { $0 as? M3UItem }
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result
        
        let expextation = expectation(description: #function)
        var isLoadCalled = false
        
        let dataTask = try self.sut.load(with: urlString) { response in
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
        XCTAssertEqual(dataTask.originalRequest?.url?.absoluteString, urlString)
    }
    
    func test_loadURLString_callsInCorrectDispatchQueue() throws {
        let data = String.M3UPlaylist.demo.utf8EncodingData
        let urlString = "https://example.com/" + #function.description
        let response = HTTPURLResponse(urlString: urlString, statusCode: 200)!
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        MockURLSession.results[urlString] = result

        let targetQueue = DispatchQueue(label: #function)
        
        let expextation = expectation(description: #function)
        var isLoadCalled = false
        
        let dataTask = try self.sut.load(with: urlString, dispatchQueue: targetQueue) { response in
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
        XCTAssertEqual(dataTask.originalRequest?.url?.absoluteString, urlString)
    }
    

}
