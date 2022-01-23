//
//  M3UPlaylistLoader.ResponseHandler.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation
import Networker

extension M3UPlaylistLoader {
    /// The extended M3U playlist response handler.
    struct ResponseHandler {
        /// Handles the extended M3U playlist response and returns result.
        /// - Parameter response: The raw extended M3U playlist request result.
        /// - Returns: The extended M3U playlist response handler result.
        func handle(_ response: DataResult) -> ParserResult {
            let result: ParserResult
            switch response {
            case let .success(response):
                let playlist = response.data.utf8String
                var parser = M3UPlaylistParser()
                parser.parse(playlist: playlist)
                result = .success(parser)
            case let .failure(error):
                result = .failure(error)
            }
            
            return result
        }
        
        
    }
    
    
}
