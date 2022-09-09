//
//  M3ULineParser.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation

/**
 An extended
 [M3U](https://en.wikipedia.org/wiki/M3U)
 playlist line decoder.
 */
struct M3ULineParser {
    /**
     A collected string of valid characters.
     */
    private var collector = ""
    /**
     An extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist line decoder current state.
     */
    private var state: M3ULineParserState = StartSeeker()
    /**
     An extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist line.
     */
    private(set) var line: M3UPlaylistLine?
    
    /**
     Analyzes an extended M3U playlist line character.
     - Parameter char: The character to analyze.
     - Returns: `true` - if need one more character,
     `false` - if the end of line has been reached.
     */
    mutating func feed(_ char: Character) -> Bool {
        self.state = self.state.feed(char)
        if self.state.isAppendable {
            self.collector.append(char)
        }
        if self.state.isExtTag {
            let line = M3UPlaylistLine(tag: self.collector)
            if line.isExtInf {
                self.state = RuntimeStartSeeker()
            }
            self.line = line
            self.collector = ""
        } else if self.state.isRuntime {
            try? self.line?.setRuntime(self.collector)
            self.collector = ""
        }
        if self.state.isEndOfLine {
            try? self.buildLine()
        }
        
        return !self.state.isEndOfLine
    }
    
    /**
     Builds extended M3U playlist line.
     */
    mutating func buildLine() throws {
        if self.line == nil {
            self.line = M3UPlaylistLine(line: self.collector)
        } else {
            try self.line?.complete(value: self.collector)
        }
    }
    
    
}
