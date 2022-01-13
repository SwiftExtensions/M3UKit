import Foundation

/// M3U playlist lines converter to playlist items.
struct M3ULinesConverter {
    // Parsed lines of M3U playlist.
    let lines: [M3UPlaylistLine]
    
    /// Builds M3U playlist items from playlist lines.
    /// - Returns: M3U playlist items from playlist lines.
    func buildItems() -> [M3UPlaylistItem] {
        var runtime: TimeInterval?
        var title = ""
        var group: String?
        var items = [M3UPlaylistItem]()
        lines.forEach { line in
            switch line {
            case .extM3U:
                break
            case let .extInf(trackRuntime, trackTitle):
                runtime = trackRuntime
                title = trackTitle
            case let .extGrp(groupTitle):
                group = groupTitle
            case let .resource(string):
                let resource = M3UPlaylistItem.Resource(string: string)
                let item = M3UPlaylistItem(
                    runtime: runtime,
                    title: title,
                    group: group,
                    resource: resource)
                items.append(item)
                runtime = nil
                title = ""
            }
        }
        
        return items
    }
    
    
}
