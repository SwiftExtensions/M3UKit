//
//  M3UPlaylistLineDecoder.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation

/**
 An extended M3U playlist line decoder.
 
 More info see [M3U](https://en.wikipedia.org/wiki/M3U).
 */
struct M3UPlaylistLineDecoder {
    /**
     A collected string of valid characters.
     */
    private var collector = ""
    /**
     An extended M3U playlist line decoder current state.
     */
    private var state: M3UPlaylistLineDecoderState = StartSeeker()
    /**
     An extended M3U playlist tag of current line (_if available_).
     
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    private var extTag: M3UExtTag?
    /**
     Runtime of track in seconds. Available only for `#EXTINF:` tag.
     
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    private var runtime: TimeInterval?
    /**
     An extended M3U playlist line.
     */
    private(set) var line: M3UPlaylistLine? = nil
    
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
            self.extTag = M3UExtTag(rawValue: self.collector)
            if self.extTag == .extInf {
                self.state = RuntimeStartSeeker()
            }
            self.collector = ""
        } else if self.state.isRuntime {
            self.runtime = TimeInterval(self.collector)
            self.collector = ""
        }
        if self.state.isEndOfLine {
            self.buildLine()
        }
        
        return !self.state.isEndOfLine
    }
    
    /**
     Builds extended M3U playlist line.
     */
    mutating func buildLine() {
        if let extTag = self.extTag {
            self.buildLine(of: extTag)
        } else if let extTag = M3UExtTag(rawValue: self.collector) {
            self.buildLine(of: extTag)
        } else {
            self.line = M3UPlaylistLine.resource(self.collector)
        }
    }
    
    /**
     Builds an extended M3U playlist line.
     - Parameter extTag: Extended M3U tag of current line.
     */
    private mutating func buildLine(of extTag: M3UExtTag) {
        switch extTag {
        case .extM3U:
            self.line = .extM3U
        case .extInf:
            self.line = .extInf(runtime: self.runtime, title: self.collector)
        case .extGrp:
            self.line = .extGrp(self.collector)
        }
    }
    
    
}
