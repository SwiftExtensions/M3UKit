//
//  M3UPlaylistLine.Error.swift
//  M3UKit
//
//  Created by Александр Алгашев on 17.02.2022.
//

import Foundation

public extension M3UPlaylistLine {
    /**
     An extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist line error.
     */
    enum Error: Swift.Error, Equatable {
        /**
         The current line is not support `runtime` parameter.
         
         This parameter is suppotrd only track information line.
         
         Example:
         ```
         #EXTINF:123,Artist Name – Track Title
         ```
         More info see [M3U](https://en.wikipedia.org/wiki/M3U).
         
         - Parameters:
          - line: An extended
         [M3U](https://en.wikipedia.org/wiki/M3U)
         playlist line.
         */
        case runtimeNotFound(line: M3UPlaylistLine)
        
        
    }
    
    
}

// MARK: - LocalizedError

extension M3UPlaylistLine.Error: LocalizedError {
    /**
     The string representation of an extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist line error.
     */
    public var errorDescription: String? {
        let errorDescription: String
        switch self {
        case let .runtimeNotFound(line: line):
            let message = #"The line does not support "runtime" parameter"#
            let comment = message + "."
            let key = message + ": \(line)."
            errorDescription = NSLocalizedString(key, comment: comment)
        }
        
        return errorDescription
    }
    
    
}
