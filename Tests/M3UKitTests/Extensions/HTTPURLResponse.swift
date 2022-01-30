//
//  HTTPURLResponse.swift
//  
//
//  Created by Александр Алгашев on 30.01.2022.
//

import Foundation

extension HTTPURLResponse {
    static var ok200: HTTPURLResponse {
        let url = URL(string: "https://example.com/")!
        
        return HTTPURLResponse(
            url: url,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)!
    }
    
    
}
