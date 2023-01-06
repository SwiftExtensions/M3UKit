//
//  M3UItem.Key.swift
//  M3UKit
//
//  Created by Александр Алгашев on 04.12.2022.
//

public extension M3UItem {
    /**
     The key of the
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist track info.
     */
    enum Key: String {
        /**
         The track runtime in seconds key.
        
         Example:
         ```
         #EXTINF:123,Artist Name – Track Title
         ```
         More info see [M3U](https://en.wikipedia.org/wiki/M3U).
         */
        case runtime
        /**
         The track title key.
        
         Example:
         ```
         #EXTINF:123,Artist Name – Track Title
         ```
         More info see [M3U](https://en.wikipedia.org/wiki/M3U).
         */
        case title
        /**
         A group name key.
        
         Example:
         ```
         #EXTGRP:Foreign Channels
         ```
         More info see [M3U](https://en.wikipedia.org/wiki/M3U).
         */
        case group
        /**
         The track resource key.
        
         Example:
         ```
         artist - title.mp3
         ```
         More info see [M3U](https://en.wikipedia.org/wiki/M3U).
         */
        case resource
        
        
    }
    
    
}

// MARK: CustomStringConvertible

extension M3UItem.Key: CustomStringConvertible {
    /**
     A textual representation of the key of the
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist track info.
     */
    public var description: String { "." + self.rawValue }
    
    
}
