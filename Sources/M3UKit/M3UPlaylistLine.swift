//
//  M3UPlaylistLine.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation

/**
 An extended M3U playlist line.
 More info see [M3U](https://en.wikipedia.org/wiki/M3U).
 */
public enum M3UPlaylistLine: Equatable {
    /**
     The file header, must be the first line of the file.
     
     Example:
     ```
     #EXTM3U
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    case extM3U
    /**
     The track information: `runtime` in seconds and display `title`.
     
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     
     - Parameters:
       - runtime: The track runtime in seconds, if any.
       - title: The track title.
     */
    case extInf(runtime: TimeInterval?, title: String)
    /**
     The begin named grouping.
     
     Example:
     ```
     #EXTGRP:Foreign Channels
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    case extGrp(_ group: String)
    /**
     The track resource.
     
     Example:
     ```
     artist - title.mp3
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    case resource(_ string: String)
    
    
}
