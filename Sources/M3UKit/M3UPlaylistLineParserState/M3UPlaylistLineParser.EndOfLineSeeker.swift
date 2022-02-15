//
//  M3UPlaylistLineDecoder.EndOfLineSeeker.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

extension M3UPlaylistLineDecoder {
    /// The search for the end of M3U playlist line is underway.
    ///
    /// The search continues until a character equal to the new line is found.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    struct EndOfLineSeeker: M3UPlaylistLineParserState {
        let isAppendable: Bool
        let isExtTag: Bool
        let isRuntime: Bool
        let isEndOfLine = false
        
        /// Default state.
        ///
        /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
        static let `default` = EndOfLineSeeker(isAppendable: true, isExtTag: false, isRuntime: false)
        /// Track resource line.
        ///
        /// Example:
        /// ```
        /// artist - title.mp3
        /// ```
        /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
        static let resource = EndOfLineSeeker(isAppendable: true, isExtTag: false, isRuntime: false)
        /// Extended M3U tag.
        /// 
        /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
        static let extTag = EndOfLineSeeker(isAppendable: true, isExtTag: true, isRuntime: false)
        /// Track title of extended M3U tag.
        ///
        /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
        static let trackTitle = EndOfLineSeeker(isAppendable: false, isExtTag: false, isRuntime: true)
        /// Track title of extended M3U tag without a separator between runtime.
        ///
        /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
        static let trackInfoWithoutSeparator = EndOfLineSeeker(isAppendable: true, isExtTag: false, isRuntime: true)
        /// Track title of extended M3U tag without runtime.
        ///
        /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
        static let trackInfoWithoutRuntime = EndOfLineSeeker(isAppendable: true, isExtTag: false, isRuntime: false)
        
        func feed(_ char: Character) -> M3UPlaylistLineParserState {
            let state: M3UPlaylistLineParserState
            if char.isNewline {
                state = EndOfLineState(isExtTag: false)
            } else {
                state = EndOfLineSeeker.default
            }
            
            return state
        }
        
        
    }
    
    
}
