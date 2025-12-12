//
//  M3UParser.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation

/**
 An extended M3U playlist parser.
 
 More info see [M3U](https://en.wikipedia.org/wiki/M3U).
 */
public struct M3UParser {
    /**
     Converts an extended M3U playlist into to items.
     - Parameter string: The string representation of an extended M3U playlist.
     */
    public func parse(string: String) throws -> [M3UItemRepresentable] {
        let string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if string.isEmpty {
            throw M3UParser.Error.contentNotFound
        }

        let streamParser = M3UStreamParser()
        string.forEach { char in
            streamParser.feed(char)
        }
        streamParser.finish()

        return try streamParser.result.get()
    }
    /**
     Converts data into string and recieved string converts into extended M3U playlist items.
     - Parameter data: Data representation of extended M3U playlist.
     */
    public func parse(data: Data) throws -> [M3UItemRepresentable] {
        try self.parse(string: data.utf8String)
    }
    
    
}
