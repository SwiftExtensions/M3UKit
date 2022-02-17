//
//  M3UPlaylistLineDecoder.StartSeeker.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

extension M3UPlaylistLineDecoder {
    /// The search for the beginning of the line is underway.
    ///
    /// The search continues until a character not equal to the new line is found.
    ///
    /// `#` - indicates the beginning of the extended M3U tag,
    /// otherwise indicates  the beginning of the track resource
    /// except new line characters.
    struct StartSeeker: M3UPlaylistLineDecoderState {
        let isAppendable = false
        let isExtTag = false
        let isRuntime = false
        let isEndOfLine = false
        
        func feed(_ char: Character) -> M3UPlaylistLineDecoderState {
            let state: M3UPlaylistLineDecoderState
            if char == "#" {
                state = ExtTagEndSeeker()
            } else if !char.isNewline {
                state = EndOfLineSeeker.resource
            } else {
                state = self
            }
            
            return state
        }
        
        
    }
    
    
}
