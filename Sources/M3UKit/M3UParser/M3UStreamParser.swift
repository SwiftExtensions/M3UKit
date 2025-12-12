import Foundation

/**
 An incremental (streaming) M3U parser.

 Use this parser when you want to feed characters one-by-one (for example, while reading a large file or a network stream)
 and produce a playlist at the end.

 Example of usage:
 ```swift
 import M3UKit

 let streamParser = M3UStreamParser()
 String.M3UPlaylist.demo.forEach { streamParser.feed($0) }
 streamParser.finish()
 switch streamParser.result {
 case let .success(playlist):
     print(playlist)
 case let .failure(error):
     print(error)
 }
 ```
 */
public final class M3UStreamParser {
    /**
     The stream parser result.

     The value represents both parsing progress and the final parsing result:
     - Before any call to `feed(_:)` the value is `.failure(M3UStreamParser.StateError.feedNotCalled)`.
     - After the first call to `feed(_:)` and before `finish()` the value is `.failure(M3UStreamParser.StateError.finishNotCalled)`.
     - After calling `finish()` the value becomes either `.success([M3UItemRepresentable])` or `.failure(Swift.Error)`.
     */
    public private(set) var result: Result<[M3UItemRepresentable], Swift.Error>

    /**
     A collector used by the internal character handlers to build the parsed items.
     */
    private var collector: ItemsCollector
    /**
     The current character handler (state machine) used to parse the next character.
     */
    private var handler: CharacterHandler
    /**
     Indicates whether any non-whitespace content has been fed.
     */
    private var hasNonWhitespaceContent: Bool

    /**
     Returns `true` when `result` contains a terminal value (either `.success` or a non-state error).

     While the parser is in a state error (`feedNotCalled` / `finishNotCalled`) it is considered non-terminal.
     */
    private var isTerminalResult: Bool {
        guard let stateError = self.result.error?.m3uStreamParserStateError else { return true }
        return stateError != .feedNotCalled && stateError != .finishNotCalled
    }

    /**
     Creates a new stream parser instance.
     */
    public init() {
        self.result = .failure(StateError.feedNotCalled)
        self.collector = ItemsCollector()
        self.handler = LineStartDetector(collector: self.collector)
        self.hasNonWhitespaceContent = false
    }

    /**
     Feeds the next character into the parser.

     Warning: After feeding all characters, you must call `finish()` to finalize parsing and update `result`.
     Until `finish()` is called, `result` remains in the state error `.finishNotCalled`.

     - Parameter char: The next character of the playlist source.
     */
    public func feed(_ char: Character) {
        switch self.result.error?.m3uStreamParserStateError {
        case .feedNotCalled:
            self.result = .failure(StateError.finishNotCalled)
        case .finishNotCalled:
            break
        default:
            return
        }

        if !char.isWhitespace && !char.isNewline {
            self.hasNonWhitespaceContent = true
        }

        if let nextHandler = self.handler.feed(char) {
            self.handler = nextHandler
        }
    }
    /**
     Finishes parsing and returns the parsed playlist.

     Warning: You must call `feed(_:)` at least once before calling `finish()`.
     If `finish()` is called before any `feed(_:)` call, `result` remains in the state error `.feedNotCalled`.

     Call this method once you have fed all characters.

     After calling this method, inspect `result`.

     Example of usage:
     ```swift
     import M3UKit

     let streamParser = M3UStreamParser()
     for char in "#EXTM3U\n#EXTINF:-1,Demo\nhttp://example.com/1\n" {
         streamParser.feed(char)
     }
     streamParser.finish()
     print(streamParser.result)
     ```
     */
    public func finish() {
        guard self.result.error?.m3uStreamParserStateError == .finishNotCalled else {
            return
        }

        guard self.hasNonWhitespaceContent else {
            self.result = .failure(M3UParser.Error.contentNotFound)
            return
        }

        if let nextHandler = self.handler.feed("\n") {
            self.handler = nextHandler
        }

        if self.collector.items.isEmpty {
            self.result = .failure(M3UParser.Error.malformedM3UPlaylist)
            return
        }

        self.result = .success(self.collector.items)
    }

    /**
     Resets the internal parsing state.

     Call this method to reuse the same instance for parsing a new playlist.
     */
    public func reset() {
        self.result = .failure(StateError.feedNotCalled)
        self.collector = ItemsCollector()
        self.handler = LineStartDetector(collector: self.collector)
        self.hasNonWhitespaceContent = false
    }
    
    
}
