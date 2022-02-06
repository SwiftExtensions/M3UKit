//
//  File.swift
//  
//
//  Created by Александр Алгашев on 06.02.2022.
//

import Foundation

extension URLSession {
    static func mockSession(protocolClass: AnyClass) -> URLSession {
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.protocolClasses = [protocolClass]
        URLProtocol.registerClass(protocolClass)
        
        return URLSession(configuration: sessionConfiguration)
    }
    
    
}
