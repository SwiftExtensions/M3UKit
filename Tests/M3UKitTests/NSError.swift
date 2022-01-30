//
//  NSError.swift
//  
//
//  Created by Александр Алгашев on 30.01.2022.
//

import Foundation

extension NSError {
    static var urlRequestTimedOut: NSError {
        NSError(
            domain: NSURLErrorDomain,
            code: NSURLErrorTimedOut,
            userInfo: nil)
    }
    
    
}
