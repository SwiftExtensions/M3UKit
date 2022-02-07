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
    
    override func setUpWithError() throws {
        self.mockSession = URLSession.mockSession(protocolClass: MockURLSession.self)
    }
    
    override func tearDownWithError() throws {
        self.mockSession = nil
    }

    
}

// MARK: - Path tests

extension M3UPlaylistLoaderTests {
    func test_loadPathError_callsFailture() throws {
        let expectedError = NSError.urlRequestTimedOut
        let result = MockURLSession.Result(data: nil, response: nil, error: expectedError)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(path: path) { response in
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)
            
            let actualError = response.failure as NSError?
            XCTAssertNotNil(actualError)
            XCTAssertEqual(actualError?.domain, expectedError.domain)
            XCTAssertEqual(actualError?.code, expectedError.code)
            
            MockURLSession.results[path] = nil
        }
        XCTAssertNotNil(dataTask)
    }
    
    func test_loadPath_callsSuccess() throws {
        let data = M3UDemoPlaylist.dataExample
        let response = HTTPURLResponse.ok200
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result

        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(path: path) { response in
            XCTAssertNotNil(response.success)
            XCTAssertNil(response.failure)
            XCTAssertEqual(response.success?.lines, M3UDemoPlaylist.linesExample)
            XCTAssertEqual(response.success?.items, M3UDemoPlaylist.itemsExample)
            
            MockURLSession.results[path] = nil
        }
        XCTAssertNotNil(dataTask)
    }

    @available(iOS 10.0, *)
    func test_loadPath_callsInCorrectDispatchQueue() {
        let data = M3UDemoPlaylist.dataExample
        let response = HTTPURLResponse.ok200
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result

        let targetQueue = DispatchQueue(label: #function)

        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(path: path, dispatchQueue: targetQueue) { response in
            dispatchPrecondition(condition: .onQueue(targetQueue))
            DispatchQueue.main.async {
                XCTAssertNotNil(response.success)
                XCTAssertNotNil(response.failure)
                
                MockURLSession.results[path] = nil
            }
        }
        XCTAssertNotNil(dataTask)
    }
    

}

// MARK: - URL tests

extension M3UPlaylistLoaderTests {
    func test_loadURLError_callsFailture() throws {
        let expectedError = NSError.urlRequestTimedOut
        let result = MockURLSession.Result(data: nil, response: nil, error: expectedError)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result
        let url = URL(string: path)!
        
        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(url: url) { response in
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)

            let actualError = response.failure as NSError?
            XCTAssertNotNil(actualError)
            XCTAssertEqual(actualError?.domain, expectedError.domain)
            XCTAssertEqual(actualError?.code, expectedError.code)
            
            MockURLSession.results[path] = nil
        }
        XCTAssertNotNil(dataTask)
    }

    func test_loadURL_callsSuccess() throws {
        let data = M3UDemoPlaylist.dataExample
        let response = HTTPURLResponse.ok200
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result
        let url = URL(string: path)!

        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(url: url) { response in
            XCTAssertNotNil(response.success)
            XCTAssertNil(response.failure)
            XCTAssertEqual(response.success?.lines, M3UDemoPlaylist.linesExample)
            XCTAssertEqual(response.success?.items, M3UDemoPlaylist.itemsExample)
            
            MockURLSession.results[path] = nil
        }
        XCTAssertNotNil(dataTask)
    }

    @available(iOS 10.0, *)
    func test_loadURL_callsInCorrectDispatchQueue() {
        let data = M3UDemoPlaylist.dataExample
        let response = HTTPURLResponse.ok200
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result
        let url = URL(string: path)!

        let targetQueue = DispatchQueue(label: #function)

        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(url: url, dispatchQueue: targetQueue) { response in
            dispatchPrecondition(condition: .onQueue(targetQueue))
            DispatchQueue.main.async {
                XCTAssertNotNil(response.success)
                XCTAssertNotNil(response.failure)
                
                MockURLSession.results[path] = nil
            }
        }
        XCTAssertNotNil(dataTask)
    }


}

// MARK: - Request tests

extension M3UPlaylistLoaderTests {
    func test_loadRequestError_callsFailture() throws {
        let expectedError = NSError.urlRequestTimedOut
        let result = MockURLSession.Result(data: nil, response: nil, error: expectedError)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result
        let url = URL(string: path)!
        let request = URLRequest(url: url)

        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(request: request) { response in
            XCTAssertNil(response.success)
            XCTAssertNotNil(response.failure)

            let actualError = response.failure as NSError?
            XCTAssertNotNil(actualError)
            XCTAssertEqual(actualError?.domain, expectedError.domain)
            XCTAssertEqual(actualError?.code, expectedError.code)
            
            MockURLSession.results[path] = nil
        }
        XCTAssertNotNil(dataTask)
    }

    func test_loadRequest_callsSuccess() throws {
        let data = M3UDemoPlaylist.dataExample
        let response = HTTPURLResponse.ok200
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result
        let url = URL(string: path)!
        let request = URLRequest(url: url)

        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(request: request) { response in
            XCTAssertNotNil(response.success)
            XCTAssertNil(response.failure)
            XCTAssertEqual(response.success?.lines, M3UDemoPlaylist.linesExample)
            XCTAssertEqual(response.success?.items, M3UDemoPlaylist.itemsExample)
            
            MockURLSession.results[path] = nil
        }
        XCTAssertNotNil(dataTask)
    }

    @available(iOS 10.0, *)
    func test_loadRequest_callsInCorrectDispatchQueue() {
        let data = M3UDemoPlaylist.dataExample
        let response = HTTPURLResponse.ok200
        let result = MockURLSession.Result(data: data, response: response, error: nil)
        let path = "https://example.com/" + #function.description
        MockURLSession.results[path] = result
        let url = URL(string: path)!
        let request = URLRequest(url: url)

        let targetQueue = DispatchQueue(label: #function)

        self.sut = M3UPlaylistLoader(session: self.mockSession)
        let dataTask = self.sut.load(request: request, dispatchQueue: targetQueue) { response in
            dispatchPrecondition(condition: .onQueue(targetQueue))
            DispatchQueue.main.async {
                XCTAssertNotNil(response.success)
                XCTAssertNotNil(response.failure)
                
                MockURLSession.results[path] = nil
            }
        }
        XCTAssertNotNil(dataTask)
    }


}
