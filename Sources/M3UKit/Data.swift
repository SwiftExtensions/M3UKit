//
//  Data.swift
//  M3UKit
//
//  Created by Александр Алгашев on 06.12.2022.
//

import Foundation

public extension Data {
    /**
     Creates a string from the given Unicode code units in the UTF8 encoding.
     */
    var utf8String: String { String(decoding: self, as: UTF8.self) }
    
    
}
