//
//  M3UDirective.swift
//  M3UKit
//
//  Created by Александр Алгашев on 03.12.2022.
//

/**
 An extended
 [M3U](https://en.wikipedia.org/wiki/M3U) playlist tag.
 
 Supported tags:
 - `#EXTM3U` - `extM3U`;
 - `#EXTINF:` - `extInf`;
 - `#EXTGRP:` - `extGrp`.
 
 An extended
 [M3U](https://en.wikipedia.org/wiki/M3U) playlist example:
 ```
 #EXTM3U
 #EXTINF:123,Artist Name – Track Title
 #EXTGRP:Foreign Channels
 artist - title.mp3
 ```
 */
enum M3UDirective: String {
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
    
    
}
