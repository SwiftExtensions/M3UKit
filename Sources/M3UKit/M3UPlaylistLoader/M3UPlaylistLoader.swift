//
//  M3UPlaylistLoader.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation
import Networker

/**
 The loader of an extended
 [M3U](https://en.wikipedia.org/wiki/M3U)
 playlists.
 
 Uses
 [HTTPURLRequest](https://github.com/SwiftExtensions/HTTPURLRequest)
 library for loading.
 */
public struct M3UPlaylistLoader {
    /// The raw extended M3U playlist request result.
    public typealias DataResult = Result<DataResponse, Swift.Error>
    /// The extended M3U playlist request result.
    public typealias PlaylistResult = Result<M3UPlaylist, Swift.Error>
    /// The extended M3U playlist request completion closure.
    public typealias Completion = (PlaylistResult) -> Void
    
    /// An object that coordinates a group of related, network data-transfer tasks.
    public let session: URLSession
    
    /// Creates and initializes a URL extended M3U playlist loader with the given URLSession.
    /// - Parameter session: An object that coordinates a group of related,
    /// network data-transfer tasks (_optional_).
    /// Default value
    /// [URLSession.shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared).
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    /**
     Loads an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     - Parameters:
        - urlString: URL string to extended M3U playlist.
        - dispatchQueue: A dispatch queue for completion handlers.
     Method uses a system-provided URLSession delegate if `nil`.
        - completionHandler: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     The method calls your block whether session data task completes successfully or fails.
     The block has no return value and takes one parameter:
        - parserResult: The extended M3U playlist request result.
     - Returns: A URL session task that returns a downloaded extended M3U playlist
     if success, or `nil` - for invalid path.
     
     For network requests the `HTTPURLRequest` (`Networker` framework) is used.
     
     An example of usage:
     ```swift
     import M3UKit

     let playlistLoader = M3UPlaylistLoader()
     playlistLoader.load(with: URL_TO_PLAYLIST) { response in
         switch response {
         case let .success(playlist):
             print(playlist.items)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    @discardableResult
    public func load(
        with urlString: String,
        dispatchQueue: DispatchQueue? = nil,
        completionHandler: @escaping Completion) -> URLSessionDataTask?
    {
        let dataTask: URLSessionDataTask?
        do {
            dataTask = try self.load(with: urlString, dispatchQueue, completionHandler)
        } catch {
            completionHandler(.failure(error))
            dataTask = nil
        }
        
        return dataTask
    }
    /**
     Core path loader of extended M3U playlist.
     - Parameter urlString: URL string to extended M3U playlist.
     - Parameter dispatchQueue: A dispatch queue for completion handlers. Method uses a system-provided URLSession delegate if `nil`.
     - Parameter completion: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     - Returns: A URL session task that returns downloaded extended M3U playlist.
     */
    private func load(
        with urlString: String,
        _ dispatchQueue: DispatchQueue?,
        _ completion: @escaping Completion) throws -> URLSessionDataTask
    {
        let request = try HTTPURLRequest(path: urlString, session: self.session)
        return self.load(request, dispatchQueue, completion)
    }
    
    /// Core loader of extended M3U playlist.
    /// - Parameters:
    ///   - request: The requester of extended M3U playlist.
    ///   - dispatchQueue: A dispatch queue for completion handler. Method uses a system-provided URLSession delegate if `nil`.
    ///   - completion: The completion handler to call when the extended M3U playlist load request is complete.
    ///   This handler is executed on the delegate queue.
    /// - Returns: A URL session task that returns downloaded extended M3U playlist.
    private func load(
        _ request: HTTPURLRequest,
        _ dispatchQueue: DispatchQueue?,
        _ completion: @escaping Completion) -> URLSessionDataTask
    {
        request.dataTask() { response in
            let result = ResponseHandler().handle(response)
            if let dispatchQueue = dispatchQueue {
                dispatchQueue.async { completion(result) }
            } else {
                completion(result)
            }
        }
    }
    
    /**
     Loads an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     - Parameters:
        - url: [URL](https://developer.apple.com/documentation/foundation/url) of an extended M3U playlist.
        - dispatchQueue: A dispatch queue for completion handlers.
     Method uses a system-provided URLSession delegate if `nil`.
        - completionHandler: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     The method calls your block whether session data task completes successfully or fails.
     The block has no return value and takes one parameter:
        - parserResult: The extended M3U playlist request result.
        - completion: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     - Returns: A URL session task that returns downloaded extended M3U playlist.
     
     For network requests the `HTTPURLRequest` (`Networker` framework) is used.
     
     An example of usage:
     ```swift
     import M3UKit

     let playlistLoader = M3UPlaylistLoader()
     let url = URL(string: PATH_TO_PLAYLIST)!
     playlistLoader.load(url: url) { response in
         switch response {
         case let .success(playlist):
             print(playlist.items)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    @discardableResult
    public func load(
        url: URL,
        dispatchQueue: DispatchQueue? = nil,
        completionHandler: @escaping Completion) -> URLSessionDataTask
    {
        let request = HTTPURLRequest(url: url, session: self.session)
        return self.load(request, dispatchQueue, completionHandler)
    }
    
    /**
     Loads an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     - Parameters:
        - request: [URLRequest](https://developer.apple.com/documentation/foundation/urlrequest)
     of an extended M3U playlist.
        - dispatchQueue: A dispatch queue for completion handlers.
     Method uses a system-provided URLSession delegate if `nil`.
        - completionHandler: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     The method calls your block whether session data task completes successfully or fails.
     The block has no return value and takes one parameter:
        - parserResult: The extended M3U playlist request result.
        - completion: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     - Returns: A URL session task that returns downloaded extended M3U playlist.
     
     For network requests the `HTTPURLRequest` (`Networker` framework) is used.
     
     An example of usage:
     ```swift
     import M3UKit

     let playlistLoader = M3UPlaylistLoader()
     let url = URL(string: PATH_TO_PLAYLIST)!
     let request = URLRequest(url: url)
     playlistLoader.load(request: request) { response in
         switch response {
         case let .success(playlist):
             print(playlist.items)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    @discardableResult
    public func load(
        request: URLRequest,
        dispatchQueue: DispatchQueue? = nil,
        completionHandler: @escaping Completion) -> URLSessionDataTask
    {
        let request = HTTPURLRequest(request: request, session: self.session)
        return self.load(request, dispatchQueue, completionHandler)
    }
    
    
}
