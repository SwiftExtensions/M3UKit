/// A type that can be used to determine ``M3ULineParser`` current state.
protocol M3UPlaylistLineParserState {
    /// Valid character to collect.
    var isAppendable: Bool { get }
    /// Characters for extended M3U playlist tag identification has been collected.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    var isExtTag: Bool { get }
    /// Characters for `#EXTINF:` tag runtime identification has been collected.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    var isRuntime: Bool { get }
    /// The end of the M3U playlist line has been reached.
    var isEndOfLine: Bool { get }
    
    /// Analyze the character and determine the current state of the ``M3ULineParser`` parser.
    /// - Parameters:
    /// - char: The character to analyze.
    /// - Returns: The current state of the ``M3ULineParser`` parser.
    func feed(_ char: Character) -> M3UPlaylistLineParserState


}
