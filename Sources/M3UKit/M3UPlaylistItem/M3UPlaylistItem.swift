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
