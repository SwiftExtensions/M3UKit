//
//  M3UExtTag.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

/**
 An extended
 [M3U](https://en.wikipedia.org/wiki/M3U) playlist tag.
 
 Supported tags:
 - `#EXTM3U` - ``extM3U``;
 - `#EXTINF:` - ``extInf``;
 - `#EXTGRP:` - ``extGrp``.
 
 An extended
 [M3U](https://en.wikipedia.org/wiki/M3U) playlist example:
 ```
 #EXTM3U
 #EXTINF:123,Artist Name – Track Title
 #EXTGRP:Foreign Channels
 artist - title.mp3
 ```
 */
public enum M3UExtTag: String {
    /**
     The file header, must be the first line of the file.
     
     Example:
     ```
     #EXTM3U
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    case extM3U = "#EXTM3U"
    /**
     The track information: runtime in seconds and display title of the following resource.
     
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     artist - title.mp3
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    case extInf = "#EXTINF:"
    /**
     The begin named grouping.
     
     Example:
     ```
     #EXTGRP:Foreign Channels
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    case extGrp = "#EXTGRP:"
    
    /**
     Creates the extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist line according to the tag value.
     */
    func buildLine() -> M3UPlaylistLine {
        let line: M3UPlaylistLine
        switch self {
        case .extM3U:
            line = .extM3U
        case .extInf:
            line = .extInf
        case .extGrp:
            line = .extGrp
        }
        
        return line
    }
    
    
}
