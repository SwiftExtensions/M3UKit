//
//  M3UPlaylistLoader.swift
//  M3UKit
//
//  Created by Александр Алгашев on 23.01.2022.
//

import Foundation
import Networker

/// Loads extended M3U playlist.
///
/// Uses [HTTPURLRequest](https://github.com/SwiftExtensions/HTTPURLRequest) library for loading.
public struct M3UPlaylistLoader {
    /// The raw extended M3U playlist request result.
    public typealias DataResult = Result<DataResponse, Swift.Error>
    /// The extended M3U playlist request result.
    public typealias ParserResult = Result<M3UPlaylistParser, Swift.Error>
    /// The extended M3U playlist request completion closure.
    public typealias Completion = (ParserResult) -> Void
    
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
    
    /// Loads extended M3U playlist from network.
    /// - Parameters:
    ///   - path: URL path to extended M3U playlist.
    ///   - dispatchQueue: A dispatch queue for completion handlers. Method uses a system-provided URLSession delegate if `nil`.
    ///   - completion: The completion handler to call when the extended M3U playlist load request is complete.
    ///   This handler is executed on the delegate queue.
    public func load(
        path: String,
        dispatchQueue: DispatchQueue? = nil,
        completion: @escaping Completion)
    {
        do {
            try self.load(path, dispatchQueue, completion)
        } catch {
            completion(.failure(error))
        }
    }
    
    /// Core path loader of extended M3U playlist.
    /// - Parameters:
    ///   - path: URL path to extended M3U playlist.
    ///   - dispatchQueue: A dispatch queue for completion handlers. Method uses a system-provided URLSession delegate if `nil`.
    ///   - completion: The completion handler to call when the extended M3U playlist load request is complete.
    ///   This handler is executed on the delegate queue.
    private func load(
        _ path: String,
        _ dispatchQueue: DispatchQueue?,
        _ completion: @escaping Completion) throws
    {
        let request = try HTTPURLRequest(path: path, session: self.session)
        self.load(request, dispatchQueue, completion)
    }
    
    /// Core loader of extended M3U playlist.
    /// - Parameters:
    ///   - request: The requester of extended M3U playlist.
    ///   - dispatchQueue: A dispatch queue for completion handler. Method uses a system-provided URLSession delegate if `nil`.
    ///   - completion: The completion handler to call when the extended M3U playlist load request is complete.
    ///   This handler is executed on the delegate queue.
    private func load(
        _ request: HTTPURLRequest,
        _ dispatchQueue: DispatchQueue?,
        _ completion: @escaping Completion)
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
    
    /// Loads extended M3U playlist from network.
    /// - Parameters:
    ///   - url: URL of extended M3U playlist.
    ///   - dispatchQueue: A dispatch queue for completion handler. Method uses a system-provided URLSession delegate if `nil`.
    ///   - completion: The completion handler to call when the extended M3U playlist load request is complete.
    ///   This handler is executed on the delegate queue.
    public func load(
        url: URL,
        dispatchQueue: DispatchQueue? = nil,
        completion: @escaping Completion)
    {
        let request = HTTPURLRequest(url: url, session: self.session)
        self.load(request, dispatchQueue, completion)
    }
    
    /// Loads extended M3U playlist from network.
    /// - Parameters:
    ///   - url: URL of extended M3U playlist.
    ///   - dispatchQueue: A dispatch queue for completion handler. Method uses a system-provided URLSession delegate if `nil`.
    ///   - completion: The completion handler to call when the extended M3U playlist load request is complete.
    ///   This handler is executed on the delegate queue.
    public func load(
        request: URLRequest,
        dispatchQueue: DispatchQueue? = nil,
        completion: @escaping Completion)
    {
        let request = HTTPURLRequest(request: request, session: self.session)
        self.load(request, dispatchQueue, completion)
    }
    
    
}
