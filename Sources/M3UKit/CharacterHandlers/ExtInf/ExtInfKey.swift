//
//  ExtInfKey.swift
//  M3UKit
//
//  Created by Александр Алгашев on 05.12.2022.
//

/**
 The custom
 [M3U](https://en.wikipedia.org/wiki/M3U)
 `#EXTINF:` directive key.
 */
public enum ExtInfKey: String {
    /**
     The `"group_id"` key. The identifier of the group.
     */
    case groupID = "group_id"
    /**
     The `"group-title"` key. The name of the group.
     */
    case groupTitle = "group-title"
    
    
}
