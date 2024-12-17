//
//  M3UItemRepresentable.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 Protocol for [M3U](https://en.wikipedia.org/wiki/M3U) items.
 */
public protocol M3UItemRepresentable { }

public extension M3UItemRepresentable {
    /**
     The [M3U](https://en.wikipedia.org/wiki/M3U) playlist track info.
     */
    var item: M3UItem? {
        self as? M3UItem
    }
    
    
}
