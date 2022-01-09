extension M3ULineParser {
    /// The search for the runtime of `#EXTINF:` tag is underway.
    ///
    /// The search continues while a character equal to a number is found.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    struct RuntimeState: M3ULineParserState {
        let isAppendable = true
        let isExtTag = false
        let isRuntime = false
        let isEndOfLine = false
        
        func feed(_ char: Character) -> M3ULineParserState {
            let state: M3ULineParserState
            if char.isNumber {
                state = self
            } else if char == "," || char == " " {
                state = EndOfLineSeeker.trackTitle
            } else {
                state = EndOfLineSeeker.trackInfoWithoutSeparator
            }
            
            return state
        }
        
        
    }
    
    
}
