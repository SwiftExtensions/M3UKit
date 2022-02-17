//
//  M3UPlaylistLine.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation

/**
 An extended M3U playlist line.
 More info see [M3U](https://en.wikipedia.org/wiki/M3U).
 */
public enum M3UPlaylistLine: Equatable {
    /**
     The empty track information line: `runtime` is `nil` and display `title` is empty.
     
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    static let extInf = M3UPlaylistLine.extInf(runtime: nil, title: "")
    /**
     The empty begin named grouping line.
     
     Example:
     ```
     #EXTGRP:Foreign Channels
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    static let extGrp = M3UPlaylistLine.extGrp(group: "")
    
    /**
     The file header, must be the first line of the file.
     
     Example:
     ```
     #EXTM3U
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    case extM3U
    /**
     The track information: `runtime` in seconds and display `title`.
     
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     
     - Parameters:
       - runtime: The track runtime in seconds, if any.
       - title: The track title.
     */
    case extInf(runtime: TimeInterval?, title: String)
    /**
     The begin named grouping.
     
     Example:
     ```
     #EXTGRP:Foreign Channels
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     
     - Parameters:
       - group: The begin named grouping.
     */
    case extGrp(group: String)
    /**
     The track resource.
     
     Example:
     ```
     artist - title.mp3
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     
     - Parameters:
       - path: The track resource path.
     */
    case resource(path: String)
    /**
     The unrecognized tag.
     
     - Parameters:
       - name: The tag name.
       - title: The tag value.
     */
    case unknownTag(name: String, value: String)
    
    /**
     The flag of a track information tag.
     
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     */
    var isExtInf: Bool {
        let isExtInf: Bool
        if case .extInf(_, _) = self {
            isExtInf = true
        } else {
            isExtInf = false
        }
        
        return isExtInf
    }
    
    /**
     Sets the runtime of a track information tag.
     
     Example:
     ```
     #EXTINF:123,Artist Name – Track Title
     ```
     More info see [M3U](https://en.wikipedia.org/wiki/M3U).
     
     - Parameters:
       - runtime: The track runtime in seconds (_string representation_).
     */
    mutating func setRuntime(_ runtime: String) {
        if case .extInf(_, _) = self {
            let runtime = TimeInterval(runtime)
            self = .extInf(runtime: runtime, title: "")
        }
    }
    /**
     Completes line by adding last (_final_) part of
     an extended [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist line.
     
     Actual for:
     - an ``extInf(runtime:title:)`` line;
     - an ``extGrp(group:)`` line;
     - and an ``unknownTag(name:value:)`` line;
     
     - Parameters:
       - value: A last (_final_) part of
     an extended [M3U](https://en.wikipedia.org/wiki/M3U)
     playlist line.
     */
    mutating func complete(value: String) {
        switch self {
        case let .extInf(runtime, _):
            self = .extInf(runtime: runtime, title: value)
        case .extGrp(_):
            self = .extGrp(group: value)
        case let .unknownTag(name, _):
            self = .unknownTag(name: name, value: value)
        default:
            break
        }
    }
    
    
}

extension M3UPlaylistLine {
    /**
     Creates an extended M3U playlist line from tag value.
     
     - Parameters:
       - tag: Tag name string representation.
     */
    init(tag: String) {
        if let line = M3UExtTag(rawValue: tag)?.buildLine() {
            self = line
        } else {
            self = .unknownTag(name: tag, value: "")
        }
    }
    
    /**
     Creates an extended M3U playlist line from string representation of line value.
     
     - Parameters:
       - tag: Tag name string representation.
     */
    init(line: String) {
        if let line = M3UExtTag(rawValue: line)?.buildLine() {
            self = line
        } else {
            self = .resource(path: line)
        }
    }
    
    
}
