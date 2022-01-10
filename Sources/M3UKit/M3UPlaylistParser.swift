import Foundation

/// M3U playlist parser.
///
/// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
public struct M3UPlaylistParser {
    /// String representation of M3U playlist.
    public private(set) var playlist: String
    /// Parsed lines of M3U playlist.
    public private(set) var lines = [M3ULine]()
    /// Parsed items of M3U playlist track info.
    public private(set) var items = [M3UPlaylistItem]()
    
    /// Builds lines of M3U playlist.
    /// - Parameter playlist: String representation of M3U playlist.
    public mutating func parse(playlist: String? = nil) {
        let playlist = playlist ?? self.playlist
        var lineParser = M3ULineParser()
        self.lines = []
        playlist.appending("\n").forEach {
            if lineParser.feed($0) {
                return
            } else if let line = lineParser.line {
                self.lines.append(line)
                lineParser = M3ULineParser()
            }
        }
        self.buildItems(from: self.lines)
    }
    
    private mutating func buildItems(from lines: [M3ULine]) {
        var runtime: TimeInterval?
        var title = ""
        var group: String?
        self.items = []
        lines.forEach { line in
            switch line {
            case .extM3U:
                break
            case let .extInf(_runtime, _title):
                runtime = _runtime
                title = _title
            case let .extGrp(_group):
                group = _group
            case let .resource(_resource):
                let resource: M3UPlaylistItem.Resource
                if let url = URL(string: _resource) {
                    resource = .url(url)
                } else {
                    resource = .path(_resource)
                }
                let item = M3UPlaylistItem(runtime: runtime, title: title, group: group, resource: resource)
                self.items.append(item)
                runtime = nil
                title = ""
            }
        }
    }
    
    
}

// MARK: - Init

public extension M3UPlaylistParser {
    init() {
        self.playlist = ""
    }
    
    
}
