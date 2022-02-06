//
//  MockURLSession.swift
//  
//
//  Created by Александр Алгашев on 30.01.2022.
//

import Foundation

class MockURLSession: URLProtocol {
    static var data: Data?
    static var response: URLResponse?
    static var error: Error?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let response = MockURLSession.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }
        if let data = MockURLSession.data {
            self.client?.urlProtocol(self, didLoad: data)
        }
        if let error = MockURLSession.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
    
}
