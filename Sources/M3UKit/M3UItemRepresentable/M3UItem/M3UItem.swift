//
//  M3UItem.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 The [M3U](https://en.wikipedia.org/wiki/M3U) playlist track info.
 */
public struct M3UItem: Equatable, M3UItemRepresentable {
    /**
     Key-value pairs of [M3U](https://en.wikipedia.org/wiki/M3U) playlist track info.
     */
    public private(set) var values = [String : String]()
    
    /**
     Create instance of the [M3U](https://en.wikipedia.org/wiki/M3U) playlist track info.
     - Parameter values: Key-value pairs of
     [M3U](https://en.wikipedia.org/wiki/M3U) playlist track info.
     */
    public init(values: [String : String] = [:]) {
        self.values = values
    }
    
    public subscript(_ key: Key) -> String? {
        get { self.values[key.rawValue] }
        set { self.values[key.rawValue] = newValue }
    }
    
    public subscript(_ key: ExtInfKey) -> String? {
        get { self.values[key.rawValue] }
        set { self.values[key.rawValue] = newValue }
    }
    
    public subscript(_ key: String) -> String? {
        get { self.values[key] }
        set { self.values[key] = newValue }
    }
    
    
}
