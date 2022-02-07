//
//  M3UPlaylistItem.Resource.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

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
    enum Resource: Equatable {
        /// Path to resource, if not valid URL.
        case path(_ path: String)
        /// URL type resource.
        case url(_ url: URL)
        
        /// Path resource value, if not valid URL.
        public var path: String? { self.value.path }
        /// URL resource value.
        public var url: URL? { self.value.url }
        
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

extension M3UPlaylistItem.Resource {
    /// Track resource raw value.
    var value: (url: URL?, path: String?) {
        let value: (url: URL?, path: String?)
        switch self {
        case let .path(string):
            value = (nil, string)
        case let .url(url):
            value = (url, nil)
        }
        
        return value
    }
    
    
}
