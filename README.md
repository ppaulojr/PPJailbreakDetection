# PPJailbreakDetection

[![CI](https://github.com/ppaulojr/PPJailbreakDetection/actions/workflows/ci.yml/badge.svg)](https://github.com/ppaulojr/PPJailbreakDetection/actions/workflows/ci.yml)
[![Version](https://img.shields.io/cocoapods/v/PPJailbreakDetection.svg?style=flat)](https://cocoapods.org/pods/PPJailbreakDetection)
[![License](https://img.shields.io/cocoapods/l/PPJailbreakDetection.svg?style=flat)](https://cocoapods.org/pods/PPJailbreakDetection)
[![Platform](https://img.shields.io/cocoapods/p/PPJailbreakDetection.svg?style=flat)](https://cocoapods.org/pods/PPJailbreakDetection)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

iOS 12.0+

## Usage

```objc
if ([PPJailbreakDetection isJailbroken]) { /* ... */ }
float score = [PPJailbreakDetection jailbreakProbability]; // 0.0 ... 1.0
```

```swift
if JailbreakDetection.isJailbroken() { /* ... */ }
let score = JailbreakDetection.jailbreakProbability()
```

Detection is heuristic and can be bypassed; use it as one signal among others.
The simulator always reports "not jailbroken".

## Installation

### Swift Package Manager

```swift
.package(url: "https://github.com/ppaulojr/PPJailbreakDetection.git", from: "2.0.0")
```

### CocoaPods

PPJailbreakDetection is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PPJailbreakDetection"
```

## Author

ppaulojr, ppaulojr@gmail.com

## License

PPJailbreakDetection is available under the MIT license. See the LICENSE file for more info.
