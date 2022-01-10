import Foundation

/// M3U playlist track info.
public struct M3UPlaylistItem {
    /// Track runtime in seconds.
    ///
    /// Example:
    /// ```
    /// #EXTINF:123,Artist Name – Track Title
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    public let runtime: TimeInterval?
    /// Track title.
    ///
    /// Example:
    /// ```
    /// #EXTINF:123,Artist Name – Track Title
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    public let title: String
    /// Group name, if any.
    ///
    /// Example:
    /// ```
    /// #EXTGRP:Foreign Channels
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    public let group: String?
    /// Track resource.
    ///
    /// Example:
    /// ```
    /// artist - title.mp3
    /// ```
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    public let resource: Resource
    
    
}
