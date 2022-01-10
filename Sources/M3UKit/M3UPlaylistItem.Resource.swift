import Foundation

public extension M3UPlaylistItem {
    /// Track resource.
    ///
    /// Example:
    /// ```
    /// artist - title.mp3
    /// ```
    /// There are 2 option
    /// [URL](https://developer.apple.com/documentation/foundation/url)
    /// or path as string, if not valid URL.
    ///
    /// More info see [M3U](https://en.wikipedia.org/wiki/M3U).
    enum Resource {
        /// Path to resource, if not valid URL.
        case path(_ path: String)
        /// URL type resource.
        case url(_ url: URL)
        
        /// Creates track resource.
        /// - Parameter string: Resource string reprezentation.
        ///
        /// There are 2 option
        /// [URL](https://developer.apple.com/documentation/foundation/url)
        /// or path as string, if not valid URL.
        init(string: String) {
            if let url = URL(string: string) {
                self = .url(url)
            } else {
                self = .path(string)
            }
        }
        
        
    }
    
    
}
