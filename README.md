![Build Status](https://travis-ci.org/DenHeadless/ClosureKit.png?branch=master) &nbsp;
[![codecov.io](http://codecov.io/github/DenHeadless/ClosureKit/coverage.svg?branch=master)](http://codecov.io/github/DenHeadless/ClosureKit?branch=master)
![CocoaPod platform](https://cocoapod-badges.herokuapp.com/p/ClosureKit/badge.png) &nbsp;
![CocoaPod version](https://cocoapod-badges.herokuapp.com/v/ClosureKit/badge.png) &nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

# { } Kit

[BlocksKit](https://github.com/zwaldowski/BlocksKit) is great. It allows to replace boring delegate callbacks, target-actions with blocks, making code more readable, and allowing to stay in context of what you are implementing. But with introduction of Swift language there are parts of BlocksKit that fall flat. First of all, lot of methods use `id`, which is bridged to `AnyObject!` in Swift, which does require explicit casts and type checks before you can write any code for objects in closures. Second - it does not allow you to use Swift structs and enums.

`ClosureKit` bridges this gap. It provides generic implementation for the same methods as BlocksKit, that allows you to skip type checks and casts, and also allows usage of pure Swift enums and structs.

This project is **NOT** a replacement for BlocksKit. It's goal is to provide a more convenient API to Swift developers, that BlocksKit gives for Objective-C. ClosureKit also does not have any external dependencies except Swift standard library.

## Contents ##

- [Features](#features)
  - [CollectionType](#collectiontype)
  - [Array](#array)
  - [Dictionary](#dictionary)
- [Requirements](#requirements)
- [Installation](#installation)

## Features

## CollectionType

#### All - `ck_all`

Verify, that all objects in collection match provided block.

```swift
let collection = [1,2,3]

collection.ck_all { (element) -> Bool in return element > 0 }
=> true

collection.ck_all { (element) -> Bool in return element < 2 }
=> false
```

#### Any - `ck_any`

Verify that at least one object in collection matches the block.

```swift
let collection = [1,2,3]

collection.ck_any {(element) -> Bool in return element < 0}
=> false

collection.ck_any { (element) -> Bool in return element > 2}
=> true
```

#### Match - `ck_match`

Find first object, that match provided block

```swift
let collection = [1,2,3]
println(collection.ck_match {(element) -> Bool in  return element > 2})
=> 3
```

### None - `ck_none`

Verify that all objects in collection do not match the block.

```swift
let collection = [1,2,3]
collection.ck_none { (element) -> Bool in return element < 0 }
=> true
```

## Array

### Perform select - `ck_performSelect`

Filter array, deleting all objects, that do not match block

```swift
var array = [1, 2, -1, -2, 3]

array.ck_performSelect { (element) -> Bool in return element > 0 }
println(array)
=> [1,2,3]
```

### Perform reject - `ck_performReject`

Filter array, deleting all objects, that match block. This is reverse method to ck_performSelect.

```swift
var array = [1,2,-1,-2,3]
array.ck_performReject { (element) -> Bool in return element < 0 }
println(array)
=> [1,2,3]
```

## Dictionary


#### Perform select - `ck_performSelect`

Filter dictionary, deleting all key-value pairs, that do not match provided block.

```swift
var dictionary = [1:"a",2:"b",3:"c"]
dictionary.ck_performSelect { (key,value) -> Bool in return key > 1}
=> [2:"b",3:"c"]
```

#### Perform reject - `ck_performReject`

Filter dictionary, deleting all key-value pairs, that match provided block. This is reverse for `ck_performSelect` method.

```swift
var dictionary = [1:"a",2:"b",3:"c"]
dictionary.ck_performReject { (key,value) -> Bool in return key < 2}
=> [2:"b",3:"c"]
```

#### Reject - `ck_reject`

Find key-value pairs, that do not match provided block. This is reverse of ck_select method.

```swift
let dictionary = [1:"a",2:"b",3:"c"]
dictionary.ck_reject { (key,value) -> Bool in return key < 2}
=> [2:"b",3:"c"]
```

#### Select - `ck_select`

Find all key-value pairs, that match provided block.

```swift
let dictionary = [1:"a",2:"b",3:"c"]
dictionary.ck_select { (key,value) -> Bool in return key > 1}
=> [2:"b",3:"c"]
```

## Requirements

- iOS 8 / macOS 10.10 / tvOS 9.0 / watchOS 2.0
- Swift 3
- Xcode 8

## Installation

- CocoaPods

```ruby
   pod 'ClosureKit', '~> 1.0.0'
```

- Carthage

```
  github "DenHeadless/ClosureKit"
```
