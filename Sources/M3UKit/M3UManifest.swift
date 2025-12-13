//
//  M3UManifest.swift
//  M3UKit
//
//  Created by Александр Алгашев on 13.12.2025.
//

/**
 Represents a manifest level in an M3U/HLS playlist hierarchy.

 The typical resolution flow is:
 `index` (_points to one or more `master` playlists_)
 -> `master` (_points to one or more `media` playlists_)
 -> `media` (_points to segments_).
 */
public enum M3UManifest {
    /**
     A top-level playlist that references one or more HLS master playlists.
     */
    case index
    /**
     An HLS master playlist that references one or more HLS media playlists (variants).
     */
    case master
    /**
     An HLS media playlist that references media segments.
     */
    case media 


}
