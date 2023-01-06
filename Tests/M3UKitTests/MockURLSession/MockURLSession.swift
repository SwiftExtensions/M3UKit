//
//  MockURLSession.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 30.01.2022.
//

import Foundation

final class MockURLSession: URLProtocol {
    static var results = SafeDictionary<String, Result>()
    
    override class func canInit(with request: URLRequest) -> Bool {
        MockURLSession.results[request.url?.absoluteString ?? ""] != nil
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        let result = MockURLSession.results[request.url?.absoluteString ?? ""]
        if let response = result?.response {
            self.client?.urlProtocol(self,
                                     didReceive: response,
                                     cacheStoragePolicy: .notAllowed)
        }
        if let data = result?.data {
            self.client?.urlProtocol(self, didLoad: data)
        }
        if let error = result?.error {
            self.client?.urlProtocol(self, didFailWithError: error)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
    
    
}
