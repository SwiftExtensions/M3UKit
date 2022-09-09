//
//  M3UParser.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation
import Networker

/**
 An extended M3U playlist parser.
 
 More info see [M3U](https://en.wikipedia.org/wiki/M3U).
 */
public struct M3UParser {
    /**
     Splits extended M3U playlist into lines and convert to items.
     - Parameter string: String representation of extended M3U playlist.
     */
    public func parse(string: String) -> M3UPlaylist {
        var lineParser = M3ULineParser()
        var lines = [M3UPlaylistLine]()
        string.appending("\n").forEach {
            if lineParser.feed($0) {
                return
            } else if let line = lineParser.line {
                lines.append(line)
                lineParser = M3ULineParser()
            }
        }
        
        return M3UPlaylist(lines: lines)
    }
    /**
     Converts data into string and splits extended M3U playlist into lines and convert to items.
     - Parameter data: Data representation of extended M3U playlist.
     */
    public func parse(data: Data) -> M3UPlaylist {
        self.parse(string: data.utf8String)
    }
    
    
}
