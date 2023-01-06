//
//  String.swift
//  M3UKitTests
//
//  Created by Александр Алгашев on 05.01.2023.
//

import Foundation

extension String {
    var utf8EncodingData: Data { Data(self.utf8) }
    
    
}

extension String {
    private static let m3u = "m3u"
    
    private init(filename: String) {
        let path = Bundle.module.path(forResource: filename, ofType: .m3u)!
        self = try! String(contentsOfFile: path)
    }
    
    
}

extension String {
    struct M3UPlaylist {
        static let demo = String(filename: "demo")
        static let demoWithCustomKeys = String(filename: "demoWithCustomKeys")
        static let demoWithUnknownDirective = String(filename: "demoWithUnknownDirective")
        static let freeiptv = String(filename: "freeiptv")
    }
    
    
}
