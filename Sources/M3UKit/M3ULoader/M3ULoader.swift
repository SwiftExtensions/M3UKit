//
//  M3ULoader.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation

/**
 The loader of an extended
 [M3U](https://en.wikipedia.org/wiki/M3U)
 playlists.
 */
public struct M3ULoader {
    /**
     The extended M3U playlist request result.
     */
    public typealias PlaylistResult = Result<[M3UItemRepresentable], Swift.Error>
    /**
     The extended M3U playlist request completion closure.
     */
    public typealias Completion = (_ result: PlaylistResult) -> Void
    
    /**
     An object that coordinates a group of related, network data-transfer tasks.
     */
    public let session: URLSession
    
    /**
     Creates and initializes a URL extended M3U playlist loader with the given URLSession.
     - Parameter session: An object that coordinates a group of related,
     network data-transfer tasks (_optional_).
     Default value
     [URLSession.shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared).
     */
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    /**
     Loads an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     - Parameter urlString: URL string to extended M3U playlist.
     - Parameter dispatchQueue: A dispatch queue for completion handlers.
     Method uses a system-provided URLSession delegate if `nil`.
     - Parameter completion: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     The method calls your block whether session data task completes successfully or fails.
     The block has no return value and takes one parameter:
     - Parameter parserResult: The extended M3U playlist request result.
     - Returns: A URL session task that returns a downloaded extended M3U playlist
     if success, or `nil` - for invalid path.
     
     An example of usage:
     ```swift
     import M3UKit

     let loader = M3ULoader()
     try! loader.load(
        with: URL_TO_PLAYLIST,
        dispatchQueue: .main
     ) { [weak self] response in
         switch response {
         case let .success(playlist):
             print(playlist)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    @discardableResult
    public func load(
        with urlString: String,
        dispatchQueue queue: DispatchQueue? = nil,
        completion: @escaping Completion
    ) throws -> URLSessionDataTask {
        let url: URL?
        if #available(iOS 17.0, *) {
            url = URL(string: urlString, encodingInvalidCharacters: false)
        } else {
            url = URL(string: urlString)
        }
        
        guard let url else {
            let error = URLError(.badURL, userInfo: [
                NSLocalizedDescriptionKey : "Malformed URL: '\(urlString)'."
            ])
            throw error
        }
           
        let request = URLRequest(url: url)
        
        return self.load(with: request, dispatchQueue: queue, completion: completion)
    }
    /**
     Loads an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     - Parameter request: [URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
     of an extended M3U playlist.
     - Parameter dispatchQueue: A dispatch queue for completion handlers.
     Method uses a system-provided URLSession delegate if `nil`.
     - Parameter completion: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     The method calls your block whether session data task completes successfully or fails.
     The block has no return value and takes one parameter:
     - Parameter parserResult: The extended M3U playlist request result.
     - Returns: A URL session task that returns downloaded extended M3U playlist.
     
     An example of usage:
     ```swift
     import M3UKit

     let loader = M3ULoader()
     let url = URL(string: PATH_TO_PLAYLIST)!
     let request = URLRequest(url: url)
     loader.load(
        with: request,
        dispatchQueue: .main
     ) { [weak self] response in
         switch response {
         case let .success(playlist):
             print(playlist)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    @discardableResult
    public func load(
        with request: URLRequest,
        dispatchQueue: DispatchQueue? = nil,
        completion: @escaping Completion
    ) -> URLSessionDataTask {
        Networker(session: self.session).run(with: request) { result in
            let result = Result {
                let data = try result.get()
                let parser = M3UParser()
                let playlist = try parser.parse(data: data)
                
                return playlist
            }
            if let dispatchQueue {
                dispatchQueue.async { completion(result) }
            } else {
                completion(result)
            }
        }
    }
    
    /**
     Loads an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     - Parameter url: [URL](https://developer.apple.com/documentation/foundation/url) of an extended M3U playlist.
     - Parameter dispatchQueue: A dispatch queue for completion handlers.
     Method uses a system-provided URLSession delegate if `nil`.
     - Parameter completion: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     The method calls your block whether session data task completes successfully or fails.
     The block has no return value and takes one parameter:
     - Parameter parserResult: The extended M3U playlist request result.
     - Returns: A URL session task that returns downloaded extended M3U playlist.
     
     An example of usage:
     ```swift
     import M3UKit

     let loader = M3ULoader()
     let url = URL(string: PATH_TO_PLAYLIST)!
     loader.load(
        with: url,
        dispatchQueue: .main
     ) { [weak self] response in
         switch response {
         case let .success(playlist):
             print(playlist)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    @discardableResult
    public func load(
        with url: URL,
        dispatchQueue queue: DispatchQueue? = nil,
        completion: @escaping Completion
    ) -> URLSessionDataTask {
        let request = URLRequest(url: url)
        return self.load(with: request, dispatchQueue: queue, completion: completion)
    }
    
    
}
