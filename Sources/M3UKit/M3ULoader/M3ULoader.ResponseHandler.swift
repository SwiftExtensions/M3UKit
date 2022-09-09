//
//  M3ULoader.ResponseHandler.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation
import Networker

extension M3ULoader {
    /**
     The extended M3U playlist response handler.
     */
    struct ResponseHandler {
        /**
         Handles the extended M3U playlist response and returns result.
         - Parameter response: The raw extended M3U playlist request result.
         - Returns: The extended M3U playlist response handler result.
         */
        func handle(_ response: DataResult) -> PlaylistResult {
            let result: PlaylistResult
            do {
                let response = try response.get()
                let parser = M3UParser()
                let playlist = try parser.parse(data: response.data)
                result = .success(playlist)
            } catch {
                result = .failure(error)
            }
            
            return result
        }
        
        
    }
    
    
}
