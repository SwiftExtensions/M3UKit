//
//  M3UPlaylistLoaderTests.swift
//  
//
//  Created by Александр Алгашев on 30.01.2022.
//

import XCTest
@testable import M3UKit

class M3UPlaylistLoaderTests: XCTestCase {
    var sut: M3UPlaylistLoader!
    var mockSession: URLSession!
    
    let path = "https://example.com"
    var url: URL!
    var request: URLRequest!
    
    override func setUpWithError() throws {
        self.mockSession = URLSession.mockSession(protocolClass: MockURLSession.self)
        self.url = URL(string: self.path)!
        self.request = URLRequest(url: self.url)
    }
    
    override func tearDownWithError() throws {
        self.mockSession = nil
        self.url = nil
        self.request = nil
        
        MockURLSession.data = nil
        MockURLSession.response = nil
        MockURLSession.error = nil
    }

    
}

// MARK: - Path tests

extension M3UPlaylistLoaderTests {
    func test_loadPathError_callsFailture() throws {
        let expectedError = NSError.urlRequestTimedOut
        MockURLSession.error = expectedError
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        self.sut.load(path: self.path, dispatchQueue: .main) { response in
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)
            
            let actualError = response.failure as NSError?
            XCTAssertNotNil(actualError)
            XCTAssertEqual(actualError?.domain, expectedError.domain)
            XCTAssertEqual(actualError?.code, expectedError.code)
        }
    }
    
    func test_loadPath_callsSuccess() throws {
        MockURLSession.data = M3UDemoPlaylist.dataExample
        MockURLSession.response = HTTPURLResponse.ok200
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        self.sut.load(path: self.path, dispatchQueue: .main) { response in
            XCTAssertNotNil(response.success)
            XCTAssertNil(response.failure)
            XCTAssertEqual(response.success?.lines, M3UDemoPlaylist.linesExample)
            XCTAssertEqual(response.success?.items, M3UDemoPlaylist.itemsExample)
        }
    }
    
    @available(iOS 10.0, *)
    func test_loadPath_callsInCorrectDispatchQueue() {
        MockURLSession.data = M3UDemoPlaylist.dataExample
        MockURLSession.response = HTTPURLResponse.ok200

        let targetQueue = DispatchQueue(label: #function)

        let expectation = XCTestExpectation(description: #function)
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        self.sut.load(path: self.path, dispatchQueue: targetQueue) { response in
            dispatchPrecondition(condition: .onQueue(targetQueue))
            expectation.fulfill()
        }

        self.wait(for: [expectation], timeout: 0.01)
    }
    

}

// MARK: - URL tests

extension M3UPlaylistLoaderTests {
    func test_loadURLError_callsFailture() throws {
        let expectedError = NSError.urlRequestTimedOut
        MockURLSession.error = expectedError
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        self.sut.load(url: self.url, dispatchQueue: .main) { response in
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)
            
            let actualError = response.failure as NSError?
            XCTAssertNotNil(actualError)
            XCTAssertEqual(actualError?.domain, expectedError.domain)
            XCTAssertEqual(actualError?.code, expectedError.code)
        }
    }
    
    func test_loadURL_callsSuccess() throws {
        MockURLSession.data = M3UDemoPlaylist.dataExample
        MockURLSession.response = HTTPURLResponse.ok200
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        self.sut.load(url: self.url, dispatchQueue: .main) { response in
            XCTAssertNotNil(response.success)
            XCTAssertNil(response.failure)
            XCTAssertEqual(response.success?.lines, M3UDemoPlaylist.linesExample)
            XCTAssertEqual(response.success?.items, M3UDemoPlaylist.itemsExample)
        }
    }
    
    // TODO: - Unknown fails with multiple tests
//    @available(iOS 10.0, *)
//    func test_loadURL_callsInCorrectDispatchQueue() {
//        MockURLSession.data = M3UDemoPlaylist.dataExample
//        MockURLSession.response = HTTPURLResponse.ok200
//
//        let targetQueue = DispatchQueue(label: #function)
//
//        let expectation = XCTestExpectation(description: #function)
//        self.sut = M3UPlaylistLoader(session: self.mockSession)
//        self.sut.load(url: self.url, dispatchQueue: targetQueue) { response in
//            dispatchPrecondition(condition: .onQueue(targetQueue))
//            expectation.fulfill()
//        }
//
//        self.wait(for: [expectation], timeout: 0.01)
//    }
    

}

// MARK: - Request tests

extension M3UPlaylistLoaderTests {
    func test_loadRequestError_callsFailture() throws {
        let expectedError = NSError.urlRequestTimedOut
        MockURLSession.error = expectedError
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        self.sut.load(request: self.request, dispatchQueue: .main) { response in
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)
            
            let actualError = response.failure as NSError?
            XCTAssertNotNil(actualError)
            XCTAssertEqual(actualError?.domain, expectedError.domain)
            XCTAssertEqual(actualError?.code, expectedError.code)
        }
    }
    
    func test_loadRequest_callsSuccess() throws {
        MockURLSession.data = M3UDemoPlaylist.dataExample
        MockURLSession.response = HTTPURLResponse.ok200
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        self.sut.load(request: self.request, dispatchQueue: .main) { response in
            XCTAssertNotNil(response.success)
            XCTAssertNil(response.failure)
            XCTAssertEqual(response.success?.lines, M3UDemoPlaylist.linesExample)
            XCTAssertEqual(response.success?.items, M3UDemoPlaylist.itemsExample)
        }
    }
    
    // TODO: - Unknown fails with multiple tests
//    @available(iOS 10.0, *)
//    func test_loadRequest_callsInCorrectDispatchQueue() {
//        MockURLSession.data = M3UDemoPlaylist.dataExample
//        MockURLSession.response = HTTPURLResponse.ok200
//
//        let targetQueue = DispatchQueue(label: #function)
//
//        let expectation = XCTestExpectation(description: #function)
//        self.sut = M3UPlaylistLoader(session: self.mockSession)
//        self.sut.load(request: self.request, dispatchQueue: targetQueue) { response in
//            dispatchPrecondition(condition: .onQueue(targetQueue))
//            expectation.fulfill()
//        }
//
//        self.wait(for: [expectation], timeout: 0.01)
//    }
    

}
