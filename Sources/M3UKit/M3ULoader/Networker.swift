//
//  Networker.swift
//  M3UKit
//
//  Created by Александр Алгашев on 06.12.2022.
//

import Foundation

/**
 Network manager. Syntactic sugar for
 [URLSession](https://developer.apple.com/documentation/foundation/urlsession).
 */
struct Networker {
    /**
     An object that coordinates a group of related, network data-transfer tasks.
     */
    let session: URLSession
    
    /**
     Start network request.
     - Parameter request: A URL load request parameters.
     - Parameter completion: The completion handler to call when the load request is complete.
     This handler is executed on the delegate queue.
     This completion handler takes the following parameters:
     - Parameter data: The data returned by the server.
     - Parameter error: An error object that indicates why the request failed, or nil if the request was successful.
     - Returns: The new session data task.
     */
    func run(
        with request: URLRequest,
        completion: @escaping (Result<Data, Error>) -> Void)
    -> URLSessionDataTask {
        let task = self.session.dataTask(with: request) { response in
            let result = response.handle()
            completion(result)
        }
        task.resume()
        
        return task
    }
    
    
}
