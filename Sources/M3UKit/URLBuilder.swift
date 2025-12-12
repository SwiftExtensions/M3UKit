import Foundation

/**
 A URL builder from a string.

 Used to create a `URL` from a `String` in a consistent way across OS versions,
 while preserving the same error message format.
 */
public struct URLBuilder {
    /**
     A URL string.
     */
    public let string: String

    /**
     Creates a `URLBuilder` from the given string.
     - Parameter string: A URL string.
     */
    public init(string: String) {
        self.string = string
    }

    /**
     Builds a `URL` from the stored `string`.

     On iOS 17/macOS 14 and later it uses `URL(string:encodingInvalidCharacters:)`.

     - Returns: A valid `URL`.
     - Throws: `URLError(.badURL)` if the string cannot be converted to a `URL`.
     */
    public func build() throws -> URL {
        let url: URL?
        if #available(iOS 17.0, macOS 14.0, *) {
            url = URL(string: string, encodingInvalidCharacters: false)
        } else {
            url = URL(string: string)
        }

        guard let url else {
            let error = URLError(.badURL, userInfo: [
                NSLocalizedDescriptionKey: "Malformed URL: '\(string)'."
            ])
            throw error
        }

        return url
    }
}
