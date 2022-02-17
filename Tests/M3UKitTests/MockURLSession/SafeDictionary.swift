//
//  SafeDictionary.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 17.02.2022.
//

import Foundation

class SafeDictionary<Key: Hashable, Value> {
    private var dictionary = [Key : Value]()
    private let queue = DispatchQueue(label: "\(SafeDictionary.self)", attributes: .concurrent)
    
    subscript(key: Key) -> Value? {
        get {
            self.queue.sync {
                return self.dictionary[key]
            }
        }
        set {
            self.queue.async(flags: .barrier) {
                self.dictionary[key] = newValue
            }
        }
        
        
    }
    
    
}
