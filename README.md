# M3UKit

![action](https://github.com/SwiftExtensions/M3UKit/actions/workflows/swift.yml/badge.svg)

**M3UKit** is an easy way of parsing of extended [M3U](https://en.wikipedia.org/wiki/M3U) playlists.

## Content
- [Supported directives](#supported-directives)
- [Installation](#installation)
    - [Swift Package Manager](#swift-package-manager)
    - [CocoaPods](#cocoapods)
- [Parsing](#parsing)
- [Loading from newtwork](#loading-from-newtwork)
- [Items](items)

## Supported directives

| Directive |	Description	                                  | Example |
|-----------|-------------------------------------------------|---------|
| #EXTM3U   | file header, must be the first line of the file |	#EXTM3U	|
| #EXTINF:  | track information: runtime in seconds and display title of the following resource / additional properties as key-value pairs | #EXTINF:123,Artist Name – Track Title</br>artist - title.mp3 |
| #EXTGRP: | begin named grouping	                          | #EXTGRP:Foreign Channels |

[Go to content](#content)

## Installation

### Swift Package Manager

To add a package dependency to your `Xcode` project, select **File** > **Swift Packages** > **Add Package Dependency** and enter `M3UKit` repository URL:
```ruby
https://github.com/SwiftExtensions/M3UKit.git
```
You can also navigate to your target’s General pane, and in the `Frameworks, Libraries, and Embedded Content` section, click the `+` button, select `Add Other`, and choose `Add Package Dependency`.

For more information, see [`Adding Package Dependencies to Your App`](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app).

[Go to content](#content)

### CocoaPods
[`CocoaPods`](https://cocoapods.org/) is a dependency manager for `Swift` and `Objective-C` Cocoa projects. To integrate `M3UKit` into your `Xcode` project using `CocoaPods`, specify it in your `Podfile`:
```ruby
pod 'M3UKit', git: 'https://github.com/SwiftExtensions/M3UKit.git'
```

[Go to content](#content)

## Parsing

```swift
import M3UKit

let parser = M3UParser()
let playlist = parser.parse(string: PLAYLIST)
```
[Go to content](#content)

## Loading from newtwork

```swift
import M3UKit

let loader = M3ULoader()
try? loader.load(
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

[Go to content](#content)

## Items

```swift
import M3UKit

...
// The M3U playlist tracks.
let items = playlist.compactMap(\.item)
```

[Go to content](#content)
