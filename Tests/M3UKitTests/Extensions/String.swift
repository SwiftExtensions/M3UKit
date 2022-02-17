//
//  String.swift
//  
//
//  Created by Александр Алгашев on 12.02.2022.
//

import Foundation

extension String {
    var utf8EncodingData: Data { Data(self.utf8) }
    
    
}

extension String {
    private static let m3u = "m3u"
    
    init(playlist: String) {
        let path = Bundle.module.path(forResource: playlist, ofType: .m3u)!
        self = try! String(contentsOfFile: path)
    }
    
    
}

extension String {
    struct M3UPlaylist {
        static let demo = String(playlist: "demo")
        static let demoWithInvalidTag = String(playlist: "demoWithInvalidTag")
        static let freeiptv = String(playlist: "freeiptv")
    }
    
    
}
