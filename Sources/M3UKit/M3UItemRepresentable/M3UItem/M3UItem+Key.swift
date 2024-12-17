//
//  M3UItem+Key.swift
//  M3UKit
//
//  Created by Александр Алгашев on 17/12/2024.
//

import Foundation

// MARK: - Syntactic sugar of M3UItem.Key

public extension M3UItem {
    /**
     The track runtime in seconds.
    
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    var runtime: String? {
        get { self[.runtime] }
        set { self[.runtime] = newValue }
    }
    /**
     The track title.
    
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    var title: String? {
        get { self[.title] }
        set { self[.title] = newValue }
    }
    /**
     A group name.
    
     Example:
     ```
     #EXTGRP:Foreign Channels
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    var group: String? {
        get { self[.group] }
        set { self[.group] = newValue }
    }
    /**
     The track resource.
    
     Example:
     ```
     artist - title.mp3
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    var resource: String? {
        get { self[.resource] }
        set { self[.resource] = newValue }
    }
    /**
     The track resource URL.
    
     Example:
     ```
     http://example.com/index.m3u8
     ```
     */
    var url: URL? {
        self.resource.flatMap(URL.init(string:))
    }
    
    
}
