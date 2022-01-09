extension M3ULineParser {
    /// The search for the runtime begining of `#EXTINF:` tag is underway.
    ///
    /// The search continues until a character equal to a number or a minus is found.
    ///
    /// The spaces if any are skipped.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    struct RuntimeStartSeeker: M3ULineParserState {
        let isAppendable = false
        let isExtTag = false
        let isRuntime = false
        let isEndOfLine = false
        
        func feed(_ char: Character) -> M3ULineParserState {
            let state: M3ULineParserState
            if char.isNumber || char == "-" {
                state = RuntimeState()
            } else if char == " " {
                state = self
            } else {
                state = EndOfLineSeeker.trackInfoWithoutRuntime
            }
            
            return state
        }
        
        
    }
    
    
}
