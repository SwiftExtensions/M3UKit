//
//  M3UPlaylist.swift
//  M3UKit
//
//  Created by Александр Алгашев on 15.02.2022.
//

/**
 An extended
 [M3U](https://en.wikipedia.org/wiki/M3U)
 playlist.
 */
public struct M3UPlaylist: Equatable {
    /**
     Parsed lines of an extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist.
     */
    public let lines: [M3UPlaylistLine]
    /**
     Parsed items of playlist tracks info of an extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist.
     */
    public let items: [M3UPlaylistItem]
    
    /**
     Creates instanse of an extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist.
     
     - Parameter lines: Parsed lines of an extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist.
     */
    public init(lines: [M3UPlaylistLine]) throws {
        let items = lines.buildItems()
        if !lines.isEmpty && items.isEmpty {
            throw M3UParser.Error.m3uPlaylistIsNotRecognized
        }
            
        self.lines = lines
        self.items = items
    }
    
    
}
