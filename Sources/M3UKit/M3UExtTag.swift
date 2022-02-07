//
//  M3UExtTag.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

/// Extended M3U Tag.
/// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
public enum M3UExtTag: String {
    /// File header, must be the first line of the file.
    ///
    /// Example:
    /// ```
    /// #EXTM3U
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    case extM3U = "#EXTM3U"
    /// Track information: runtime in seconds and display title of the following resource.
    ///
    /// Example:
    /// ```
    /// #EXTINF:123,Artist Name – Track Title
    /// artist - title.mp3
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    case extInf = "#EXTINF:"
    /// Begin named grouping.
    ///
    /// Example:
    /// ```
    /// #EXTGRP:Foreign Channels
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    case extGrp = "#EXTGRP:"
    
    
}
