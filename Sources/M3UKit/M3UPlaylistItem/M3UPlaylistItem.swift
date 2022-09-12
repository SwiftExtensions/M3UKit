//
//  M3UPlaylistItem.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation

/**
 The M3U playlist track info.
 */
public struct M3UPlaylistItem: Equatable {
    /**
     The track runtime in seconds.
    
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    public let runtime: TimeInterval?
    /**
     The track title.
    
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    public let title: String
    /**
     A group name, if any.
    
     Example:
     ```
     #EXTGRP:Foreign Channels
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    public let group: String?
    /**
     The track resource.
    
     Example:
     ```
     artist - title.mp3
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    public let resource: Resource
    
    
}

// MARK: CustomDebugStringConvertible

extension M3UPlaylistItem: CustomDebugStringConvertible {
    /**
     A textual representation of ``M3UPlaylistItem``, suitable for debugging.
     */
    public var debugDescription: String {
        let runtime: String
        if let value = self.runtime {
            runtime = String(reflecting: value)
        } else {
            runtime = "nil"
        }
        let group: String
        if let value = self.group {
            group = String(reflecting: value)
        } else {
            group = "nil"
        }
        
        return "M3UPlaylistItem(runtime: \(runtime), title: \(self.title), group: \(group), resource: \(self.resource))"
    }
    
    
}
