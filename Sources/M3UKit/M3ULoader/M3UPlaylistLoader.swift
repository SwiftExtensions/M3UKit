//
//  M3UPlaylistLoader.swift
//  M3UKit
//
//  Created by Александр Алгашев on 22/12/2024.
//

import Foundation

/**
 An extended
 [M3U](https://en.wikipedia.org/wiki/M3U)
 playlist loader.
 */
public class M3UPlaylistLoader {
    /**
     The extended M3U playlist request result.
     */
    public typealias Response = Result<[M3UItemRepresentable], Swift.Error>
    /**
     The extended M3U playlist request completion closure.
     */
    public typealias Completion = (_ response: Response) -> Void
    
    /**
     URLRequest of an extended M3U playlist.
     */
    public let request: URLRequest
    /**
     An object that coordinates a group of related, network data-transfer tasks.
     */
    public var session: URLSession { self.loader.session }
    /**
     A URL session task that returns downloaded extended M3U playlist.
     */
    public private(set) var dataTask: URLSessionDataTask?
    
    /**
     The loader of an extended
     [M3U](https://en.wikipedia.org/wiki/M3U)
     playlists.
     */
    private let loader: M3ULoader
    
    /**
     Creates and initializes a URL extended M3U playlist loader with the given URLRequest and URLSession.
     - Parameter request: URLRequest of an extended M3U playlist.
     - Parameter session: An object that coordinates a group of related,
     network data-transfer tasks (_optional_).
     Default value
     [URLSession.shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared).
     
     An example of usage:
     ```swift
     import M3UKit

     let url = URL(string: PATH_TO_PLAYLIST)!
     let request = URLRequest(url: url)
     let loader = M3UPlaylistLoader(request: request)
     loader.load(dispatchQueue: .main) { [weak self] response in
         switch response {
         case let .success(playlist):
             print(playlist)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    public init(request: URLRequest, session: URLSession = .shared) {
        self.request = request
        self.loader = M3ULoader(session: session)
    }
    /**
     Creates and initializes a URL extended M3U playlist loader with the given URL and URLSession.
     - Parameter url: URL of an extended M3U playlist.
     - Parameter session: An object that coordinates a group of related,
     network data-transfer tasks (_optional_).
     Default value
     [URLSession.shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared).
     
     An example of usage:
     ```swift
     import M3UKit

     let url = URL(string: PATH_TO_PLAYLIST)!
     let loader = M3UPlaylistLoader(url: url)
     loader.load(dispatchQueue: .main) { [weak self] response in
         switch response {
         case let .success(playlist):
             print(playlist)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    public convenience init(url: URL, session: URLSession = .shared) {
        let request = URLRequest(url: url)
        self.init(request: request, session: session)
    }
    /**
     Creates and initializes a URL extended M3U playlist loader with the given URL string and URLSession.
     - Parameter urlString: URL string to extended M3U playlist.
     - Parameter session: An object that coordinates a group of related,
     network data-transfer tasks (_optional_).
     Default value
     [URLSession.shared](https://developer.apple.com/documentation/foundation/urlsession/1409000-shared).
     
     An example of usage:
     ```swift
     import M3UKit
     
     let loader = try! M3UPlaylistLoader(urlString: PATH_TO_PLAYLIST)
     loader.load(dispatchQueue: .main) { [weak self] response in
         switch response {
         case let .success(playlist):
             print(playlist)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    public convenience init(
        urlString: String,
        session: URLSession = .shared
    ) throws {
        let url = try URLBuilder(string: urlString).build()
        self.init(url: url, session: session)
    }
    
    /**
     Loads an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     - Parameter dispatchQueue: A dispatch queue for completion handlers.
     Method uses a system-provided URLSession delegate if `nil`.
     - Parameter completion: The completion handler to call when the extended M3U playlist load request is complete.
     This handler is executed on the delegate queue.
     The method calls your block whether session data task completes successfully or fails.
     The block has no return value and takes one parameter:
     - Parameter response: The extended M3U playlist request result.
     
     An example of usage:
     ```swift
     import M3UKit

     let url = URL(string: PATH_TO_PLAYLIST)!
     let request = URLRequest(url: url)
     let loader = M3UPlaylistLoader(request: request)
     loader.load(dispatchQueue: .main) { [weak self] response in
         switch response {
         case let .success(playlist):
             print(playlist)
         case let .failure(error):
             print(error)
         }
     }
     ```
     */
    public func load(
        dispatchQueue: DispatchQueue? = nil,
        completion: @escaping Completion
    ) {
        self.dataTask = self.loader.load(
            with: self.request,
            dispatchQueue: dispatchQueue,
            completion: completion
        )
    }
    /**
     Cancels loading of an extended [M3U](https://en.wikipedia.org/wiki/M3U) playlist from network.
     */
    public func cancel() {
        self.dataTask?.cancel()
    }
    
    
}
