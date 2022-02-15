//
//  M3UPlaylistLineDecoder.EndOfLineState.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

extension M3UPlaylistLineDecoder {
    /// The end of M3U playlist line.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    struct EndOfLineState: M3UPlaylistLineDecoderState {
        let isAppendable = false
        let isExtTag: Bool
        let isRuntime = false
        let isEndOfLine = true
        
        func feed(_ char: Character) -> M3UPlaylistLineDecoderState { self }
        
        
    }
    
    
}
