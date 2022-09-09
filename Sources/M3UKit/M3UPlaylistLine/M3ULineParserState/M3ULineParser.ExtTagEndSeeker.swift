//
//  M3ULineParser.ExtTagEndSeeker.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

extension M3ULineParser {
    /// The search for the extended M3U tag is underway.
    ///
    /// The search continues until a character equal to the new line or column is found.
    ///
    /// A new line indicates the end of `#EXTM3U` tag: file header.
    /// A column indicates the end of another extended M3U tag.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    struct ExtTagEndSeeker: M3ULineParserState {
        let isAppendable = true
        let isExtTag = false
        let isRuntime = false
        let isEndOfLine = false
        
        func feed(_ char: Character) -> M3ULineParserState {
            let state: M3ULineParserState
            if char.isNewline {
                state = EndOfLineState(isExtTag: true)
            } else if char == ":" {
                state = EndOfLineSeeker.extTag
            } else {
                state = self
            }
            
            return state
        }
        
        
    }
    
    
}
