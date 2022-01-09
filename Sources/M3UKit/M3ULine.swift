import Foundation

/// Extended M3U playlist line.
/// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
public enum M3ULine: Equatable {
    /// File header, must be the first line of the file.
    ///
    /// Example:
    /// ```
    /// #EXTM3U
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    case extM3U
    /// Track information: `runtime` in seconds and display `title`.
    ///
    /// Example:
    /// ```
    /// #EXTINF:123,Artist Name – Track Title
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    case extInf(_ runtime: TimeInterval?, _ title: String)
    /// Begin named grouping.
    ///
    /// Example:
    /// ```
    /// #EXTGRP:Foreign Channels
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    case extGrp(_ groupe: String)
    /// Track resource.
    ///
    /// Example:
    /// ```
    /// artist - title.mp3
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    case resource(_ resource: String)
    
    
}
