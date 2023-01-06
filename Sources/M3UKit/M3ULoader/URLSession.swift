//
//  URLSession.swift
//  M3UKit
//
//  Created by Александр Алгашев on 06.12.2022.
//

import Foundation

extension URLSession {
    /**
     Creates a task that retrieves the contents of a URL based on the specified URL request object, and calls a handler upon completion.
     
     - Parameter request: A URL request object that provides the URL, cache policy, request type, body data or body stream, and so on.
     - Parameter completion: The completion handler to call when the load request is complete. This handler is executed on the delegate queue.
     This completion handler takes the following parameters:
     - Parameter response: Syntactic sugar for URL session response.
     */
    func dataTask(
        with request: URLRequest,
        completion: @escaping (URLSessionResponse) -> Void)
    -> URLSessionDataTask {
        self.dataTask(with: request) { data, response, error in
            let response = URLSessionResponse(data: data, metadata: response, error: error)
            completion(response)
        }
    }
    
    
}
