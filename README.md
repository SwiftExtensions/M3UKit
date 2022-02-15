# M3UKit

![action](https://github.com/SwiftExtensions/M3UKit/actions/workflows/swift.yml/badge.svg)

**M3UKit** is an easy way of parsing of extended [M3U](https://en.wikipedia.org/wiki/M3U) playlists.

## Content
- [Installation](#installation)
    - [CocoaPods](#cocoapods)
    - [Swift Package Manager](#swift-package-manager)
- [Parsing](#parsing)
- [Loading from newtwork](#loading-from-newtwork)

## Installation

### CocoaPods
[`CocoaPods`](https://cocoapods.org/) is a dependency manager for `Swift` and `Objective-C` Cocoa projects. To integrate `M3UKit` into your `Xcode` project using `CocoaPods`, specify it in your `Podfile`:
```ruby
pod 'M3UKit', git: 'https://github.com/SwiftExtensions/M3UKit.git'
pod 'Networker', git: 'https://github.com/SwiftExtensions/HTTPURLRequest.git'
```

[Go to content](#content)

### Swift Package Manager

To add a package dependency to your `Xcode` project, select **File** > **Swift Packages** > **Add Package Dependency** and enter `M3UKit` repository URL:
```ruby
https://github.com/SwiftExtensions/M3UKit.git
```
You can also navigate to your target’s General pane, and in the `Frameworks, Libraries, and Embedded Content` section, click the `+` button, select `Add Other`, and choose `Add Package Dependency`.

For more information, see [`Adding Package Dependencies to Your App`](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

[Go to content](#content)

## Parsing

```swift
import M3UKit

let decoder = M3UPlaylistDecoder()
let playlist = decoder.parse(string: PLAYLIST)
```
[Go to content](#content)

## Loading from newtwork

```swift
import M3UKit

let playlistLoader = M3UPlaylistLoader()
playlistLoader.load(path: URL_TO_PLAYLIST) { response in
    switch response {
    case let .success(playlist):
        print(playlist.items)
    case let .failure(error):
        print(error)
    }
}
```

[Go to content](#content)
