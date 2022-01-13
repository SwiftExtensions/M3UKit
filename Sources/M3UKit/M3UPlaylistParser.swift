import Foundation

/// Extended M3U playlist parser.
///
/// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
public struct M3UPlaylistParser {
    /// String representation of extended M3U playlist.
    public private(set) var playlist: String
    /// Parsed lines of extended M3U playlist.
    public private(set) var lines = [M3UPlaylistLine]()
    /// Parsed items of extended M3U playlist track info.
    public private(set) var items = [M3UPlaylistItem]()
    
    /// Split extended M3U playlist into lines and convert to items.
    /// - Parameter playlist: String representation of extended M3U playlist.
    public mutating func parse(playlist: String? = nil) {
        let playlist = playlist ?? self.playlist
        var lineParser = M3UPlaylistLineParser()
        self.lines = []
        playlist.appending("\n").forEach {
            if lineParser.feed($0) {
                return
            } else if let line = lineParser.line {
                self.lines.append(line)
                lineParser = M3UPlaylistLineParser()
            }
        }
        let linesConverter = M3UPlaylistLinesConverter(lines: self.lines)
        self.items = linesConverter.buildItems()
    }
    
    
}

// MARK: - Init

public extension M3UPlaylistParser {
    /// Creates extended M3U playlist parser with empty playlist.
    init() {
        self.playlist = ""
    }
    
    
}
