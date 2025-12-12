//
//  M3UStreamParser.StateError.swift
//  M3UKit
//
//  Created by Александр Алгашев on 12/12/2025.
//

import Foundation

public extension M3UStreamParser {
    /**
     Stream parser state errors.
     */
    enum StateError: Error, Equatable {
        /**
         `feed(_:)` has not been called.
         */
        case feedNotCalled
        /**
         `finish()` has not been called.
         */
        case finishNotCalled
    }
    
    
}

// MARK: - LocalizedError

extension M3UStreamParser.StateError: LocalizedError {
    /**
     A localized description of the stream parser state error.
     */
    public var errorDescription: String? {
        let description: String
        switch self {
        case .feedNotCalled:
            let message = #"feed(_:) has not been called."#
            description = NSLocalizedString(message, comment: message)
        case .finishNotCalled:
            let message = #"finish() has not been called."#
            description = NSLocalizedString(message, comment: message)
        }

        return description
    }
    
    
}

public extension Error {
    /**
     Casts the error to `M3UStreamParser.StateError`.

     - Returns: A `M3UStreamParser.StateError` value if the error represents a stream parser state error,
       otherwise `nil`.
     */
    var m3uStreamParserStateError: M3UStreamParser.StateError? {
        self as? M3UStreamParser.StateError
    }
    
    
}
