//
//  M3UPlaylist.swift
//  M3UKit
//
//  Created by Александр Алгашев on 15.02.2022.
//

import Foundation

/**
 An extended M3U playlist.
 More info see [M3U](https://en.wikipedia.org/wiki/M3U).
 */
public struct M3UPlaylist: Equatable {
    /**
     Parsed lines of extended M3U playlist.
     */
    public let lines: [M3UPlaylistLine]
    /**
     Parsed items of extended M3U playlist track info.
     */
    public let items: [M3UPlaylistItem]
    
    /**
     Creates instanse of An extended M3U playlist.
     
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     - Parameter lines: Parsed lines of extended M3U playlist.
     */
    public init(lines: [M3UPlaylistLine]) {
        self.lines = lines
        self.items = lines.buildItems()
    }
    
    
}
