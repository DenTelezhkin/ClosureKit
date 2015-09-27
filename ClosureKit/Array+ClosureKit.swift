//
//  NSArray+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

public extension Array {
    
    /// Filter array, deleting all objects, that do not match block
    ///
    /// - parameter block: matching block.
    mutating func ck_performSelect(block: (Element) -> Bool) {
        var indexes = [Int]()
        for (index,element) in self.enumerate() {
            if !block(element) { indexes.append(index)}
        }
        
        self.removeAtIndexes(indexes)
    }
    
    /// Filter array, deleting all objects, that match block
    ///
    /// - parameter block: matching block
    mutating func ck_performReject(block: (Element) -> Bool) {
        return self.ck_performSelect({ (element) -> Bool in
            return !block(element)
        })
    }
}

private extension Array
{
    mutating func removeAtIndexes( indexes: [Int]) {
        for index in indexes.sort(>) {
            self.removeAtIndex(index)
        }
    }
}