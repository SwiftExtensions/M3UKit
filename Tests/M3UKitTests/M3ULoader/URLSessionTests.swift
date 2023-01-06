//
//  URLSessionTests.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import XCTest
@testable import M3UKit

final class URLSessionTests: XCTestCase {
    private var sut: URLSession!

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        self.sut = URLSession(configuration: .ephemeral)
    }

    override func tearDownWithError() throws {
        self.sut = nil
        
        try super.tearDownWithError()
    }

    func test_dataTask_returnsDataTask() throws {
        let urlString = "https://example.com/" + #function.description
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let dataTask = self.sut.dataTask(with: request, completion: { _ in })
        
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask.originalRequest?.url, url)
    }

    func test_dataTask_setsCompletion() throws {
        let urlString = "https://example.com/" + #function.description
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let dataTask = self.sut.dataTask(with: request, completion: { _ in })
        
        XCTAssertNotNil(dataTask)
        XCTAssertEqual(dataTask.originalRequest?.url, url)
    }


}
