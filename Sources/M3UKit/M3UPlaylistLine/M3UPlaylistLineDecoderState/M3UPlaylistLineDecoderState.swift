//
//  M3UPlaylistLineDecoderState.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

/**
 A type that can be used to determine ``M3UPlaylistLineDecoder`` current state.
 */
protocol M3UPlaylistLineDecoderState {
    /**
     A valid character to collect.
     */
    var isAppendable: Bool { get }
    /**
     Characters for extended M3U playlist tag identification has been collected flag.
     
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    var isExtTag: Bool { get }
    /**
     Characters for `#EXTINF:` tag runtime identification has been collected.
     
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    var isRuntime: Bool { get }
    /**
     The end of the M3U playlist line has been reached.
     */
    var isEndOfLine: Bool { get }
    
    /**
     Analyzes the character and determine the current state of the ``M3UPlaylistLineDecoder``.
     - Parameters:
     - char: The character to analyze.
     - Returns: The current state of the ``M3ULineParser`` parser.
     */
    func feed(_ char: Character) -> M3UPlaylistLineDecoderState


}
