//
//  M3UPlaylistLoaderResponseHandlerTests.swift
//  
//
//  Created by Александр Алгашев on 30.01.2022.
//

import XCTest
import Networker
@testable import M3UKit

class M3UPlaylistLoaderResponseHandlerTests: XCTestCase {
    typealias ResponseHandler = M3UPlaylistLoader.ResponseHandler
    
    var sut: ResponseHandler!

    override func setUpWithError() throws {
        self.sut = ResponseHandler()
    }

    override func tearDownWithError() throws {
        self.sut = nil
    }

    func test_handleError_createsFailureResult() throws {
        let expectedError = NSError.urlRequestTimedOut
        let response: Result<DataResponse, Error> = Result.failure(expectedError)
        let parser = self.sut.handle(response)
        
        XCTAssertNil(parser.success)
        XCTAssertNotNil(parser.failure)
        
        let actualError = parser.failure as NSError?
        XCTAssertNotNil(actualError)
        XCTAssertEqual(actualError?.domain, expectedError.domain)
        XCTAssertEqual(actualError?.code, expectedError.code)
    }
    
    func test_handleData_createsSuccessResult() throws {
        let data = M3UDemoPlaylist.dataExample
        let dataResponse = DataResponse(data: data, response: HTTPURLResponse.ok200)
        let response: Result<DataResponse, Error> = Result.success(dataResponse)
        let handleResult = self.sut.handle(response)
        
        XCTAssertNotNil(handleResult.success)
        XCTAssertNil(handleResult.failure)
        
        let parser = handleResult.success
        XCTAssertEqual(parser?.lines, M3UDemoPlaylist.linesExample)
        XCTAssertEqual(parser?.items, M3UDemoPlaylist.itemsExample)
    }
    

}

private extension HTTPURLResponse {
    static var ok200: HTTPURLResponse {
        let url = URL(string: "https://example.com/")!
        
        return HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)!
    }
    
    
}
