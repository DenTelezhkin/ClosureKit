![Build Status](https://travis-ci.org/DenHeadless/ClosureKit.png?branch=master) &nbsp;
![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)

# { } Kit

[BlocksKit](https://github.com/zwaldowski/BlocksKit) is great. It allows to replace boring delegate callbacks, target-actions with blocks, making code more readable, and allowing to stay in context of what you are implementing. But with introduction of Swift language there are parts of BlocksKit that fall flat. First of all, lot of methods use `id`, which is bridged to `AnyObject!` in Swift, which does require explicit casts and type checks before you can write any code for objects in closures. Second - it does not allow you to use Swift structs and enums. 

`ClosureKit` bridges this gap. It provides generic implementation for the same methods as BlocksKit, that allows you to skip type checks and casts, and also allows usage of pure Swift enums and structs.

This project is **NOT** a replacement for BlocksKit. It's goal is to provide a more convenient API to Swift developers, that BlocksKit gives for Objective-C. ClosureKit also does not have any external dependencies except Swift standard library.

## Contents ##

- [Features](#features)
  - [Array](#array)
  - [Dictionary](#dictionary)
- [Requirements](#requirements)
- [Installation](#installation)

## Features

## Array

#### All - `ck_all`

Verify, that all objects in array match provided block.

```swift
let array = [1,2,3]

array.ck_all { (element) -> Bool in return element > 0 }
=> true

array.ck_all { (element) -> Bool in return element < 2 }
=> false
```

#### Any - `ck_any`

Verify that at least one object in array matches the block.

```swift
let array = [1,2,3]

array.ck_any {(element) -> Bool in return element < 0}
=> false

array.ck_any { (element) -> Bool in return element > 2}
=> true
```

#### Each - `ck_each` 

Loops over array, executing block for each element.

```swift
let array = [1,2,3]
array.ck_each { element in
  println(element)
}
=> 1 2 3
```

#### Map - `ck_map`

Create array of new values, that is constructed by calling block on each element of current array.

```swift
let array = [1,2,3]

let stringsArray = array.ck_map { (element) -> String in return "\(element)"}
=> ["1","2","3"]
```

#### Match - `ck_match`

Find first object, that match provided block

```swift
let array = [1,2,3]
println(array.ck_match {(element) -> Bool in  return element > 2})
=> 3
```

### None - `ck_none`

Verify that all objects in array do not match the block.

```swift
let array = [1,2,3]
array.ck_none { (element) -> Bool in return element < 0 }
=> true
```

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

### Reduce - `ck_reduce`

Accumulate objects using block

```swift
var array = [1,2,3]
array.ck_reduce(initial: 0, combine: { (sum,element) -> Int in
  return sum += element
}
=> 6
```

### Reject - `ck_reject`

Find elements that do not match provided block. This is reverse for `ck_select` method.

```swift
let array = [1,2,-1,-2,3]
let filtered =array.ck_reject { (element) -> Bool in return element < 0 }
=> [1,2,3]
```

### Select - `ck_select`

Find all elements in array, that match provided block.

```swift
let array = [1, 2, -1, -2, 3]
let filtered = array.ck_select { (element) -> Bool in return element > 0 }
=> [1,2,3]
```

## Dictionary

#### All - `ck_all`

Verify, that all key-value pairs match provided block.

```swift
let dictionary = [1:"a",2:"b",3:"c"]

dictionary.ck_all { (key,value) -> Bool in return key > 0}
=> true

dictionary.ck_all { (key,value) -> Bool in return value == "d" }
=> false
```

#### Any - `ck_any`

Verify that at least one key-value matches block.

```swift
let dictionary = [1:"a",2:"b",3:"c"]

dictionary.ck_any { (key,value) -> Bool in return key > 2 }
=> true
```

#### Each - `ck_each`

Loops over elements in Dictionary and executes given block with eack key value tuple.

```swift
dictionary.ck_each { (key,value) in println("\(key): \(value)") }

// prints all keys and values
```

#### Map - `ck_map`

Create dictionary with transformed values. Keys of new dictionary remain the same, but values are a result of executing provided block on key-value pair in current dictionary

```swift
let dictionary = [1:"a",2:"b",3:"c"]

let transformed = dictionary.ck_map { (key,value) -> String in return "\(key)" + value }
=> [1:"1a",2:"2b",3:"3c"]
```

#### Match - `ck_match`

Find first element in Dictionary that is matching the block. If none matches, return nil.

```swift
let dictionary = [1:"a",2:"b",3:"c"]
if let (key,value) = dictionary.ck_match {(key,value) -> Bool in return key > 2} {
  println("\(key)"+value) 
}
=> 3c
```

#### None - `ck_none`

Verify, that none of the key-value pairs match provided block.

```swift
let dictionary = [1:"a",2:"b",3:"c"]

dictionary.ck_none { (key,value) -> Bool in return key > 3 }
=> true
```

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

- iOS 7 and higher / Mac OS X 10.9 or higher
- If you are using CocoaPods or embedded frameworks - iOS 8 and higher / Mac OS X 10.10 or higher.

## Installation

Because of XCode and Swift compiler errors ability to make public extensions on generic classes has been turned off by Apple. This disallows installation via CocoaPods or as Embedded framework. When public extensions will be enabled, project will be distributed more conveniently( as of **XCode 6.2 beta 5** public extensions are still turned off).

The only supported way of installing project is via git submodules and drag and drop to project.
