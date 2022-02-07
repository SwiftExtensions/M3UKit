//
//  MockURLSession.Result.swift
//  
//
//  Created by Александр Алгашев on 07.02.2022.
//

import Foundation

extension MockURLSession {
    struct Result {
        let data: Data?
        let response: URLResponse?
        let error: Error?
        
        
    }
    
    
}
