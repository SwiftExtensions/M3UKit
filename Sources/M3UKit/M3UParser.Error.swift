//
//  M3UParser.Error.swift
//  M3UKit
//
//  Created by Александр Алгашев on 09.09.2022.
//

import Foundation

public extension M3UParser {
    /**
     An extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     parser error.
     */
    enum Error: Swift.Error, Equatable {
        /**
         Not found any content to parse.
         */
        case contentNotFound
        /**
         Invalid M3U playlist.
         */
        case invalidM3UPlaylist
        
        
    }
    
    
}

// MARK: LocalizedError

extension M3UParser.Error: LocalizedError {
    /**
     The string representation of an extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     parser error.
     */
    public var errorDescription: String? {
        let errorDescription: String
        switch self {
        case .contentNotFound:
            let message = #"Empty media resource. Not found any content to parse."#
            errorDescription = NSLocalizedString(message, comment: message)
        case .invalidM3UPlaylist:
            let message = #"Invalid M3U playlist."#
            errorDescription = NSLocalizedString(message, comment: message)
        }
        
        return errorDescription
    }
    
    
}
