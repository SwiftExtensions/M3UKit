//
//  HTTPURLResponse.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 06.01.2023.
//

import Foundation

extension HTTPURLResponse {
    convenience init?(urlString: String, statusCode: Int) {
        guard let url = URL(string: urlString) else { return nil }
        
        self.init(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
    }
    
    
}
