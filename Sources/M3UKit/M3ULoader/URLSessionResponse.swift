//
//  URLSessionResponse.swift
//  M3UKit
//
//  Created by Александр Алгашев on 06.12.2022.
//

import Foundation

/**
 Syntactic sugar for
 [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
 method
 [dataTask(with:completionHandler:)](https://developer.apple.com/documentation/foundation/urlsession/1407613-datatask)
 completionHandler.
 */
struct URLSessionResponse {
    /**
     The data returned by the server.
     */
    let data: Data?
    /**
     An object that provides response metadata, such as HTTP headers and status code.
     If you are making an HTTP or HTTPS request, the returned object is actually an HTTPURLResponse object.
     */
    let metadata: URLResponse?
    /**
     An error object that indicates why the request failed, or `nil` if the request was successful.
     */
    let error: Error?
    
    /**
     Handle server response parameters.
     - Returns: Either a data or a error.
     */
    func handle() -> Result<Data, Error> {
        let result: Result<Data, Error>
        if let error {
            result = .failure(error)
        } else if let data {
            result = .success(data)
        } else {
            let error = URLError(.badServerResponse, userInfo: [
                NSLocalizedDescriptionKey : "Unknown error."
            ])
            result = .failure(error)
        }
        
        return result
    }
    
    
}
