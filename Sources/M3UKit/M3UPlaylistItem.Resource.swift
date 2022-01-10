import Foundation

/// Track resource.
///
/// Example:
/// ```
/// artist - title.mp3
/// ```
/// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
public extension M3UPlaylistItem {
    enum Resource {
        /// Path to resource, if not valid URL.
        case path(_ path: String)
        /// URL type resource.
        case url(_ url: URL)
        
        
    }
    
    
}
