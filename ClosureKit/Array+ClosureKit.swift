//
//  NSArray+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

public extension Array {
    
    /// Verify, that all objects in array match the block
    ///
    /// - parameter block: matching block
    /// - returns: true, if all objects match the block. If any object does not match - false
    func ck_all( block: (Element) -> Bool) -> Bool {
        for (_, value) in self.enumerate() {
            var stop = false
            stop = block(value)
            if stop {
                return false;
            }
        }
        return true
    }
    
    /// Verify that at least one object in array matches the block.
    ///
    /// - parameter block: matching block
    /// - returns: true, if any object matches the block. If none matches - false
    func ck_any( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) != nil
    }
    
    /// Loops over elements in array and executes given block with each element
    ///
    /// - parameter block: block to execute
    func ck_each(block: (Element) -> ())
    {
        for element in self {
            block(element)
        }
    }
    
    /// Create array of new values, that is constructed by calling block on each element of current array.
    ///
    /// - parameter transform: mapping block
    /// - returns: Array of transformed values
    func ck_map<U>(transform : (Element) -> U ) -> [U] {
        return self.map(transform)
    }
    
    /// Find first element in array that is matching the block.
    /// If none matches, return nil
    ///
    /// - parameter block: block to match against
    /// - returns: Object, if found, nil if not.
    func ck_match(block : (Element) -> Bool) -> Element? {
        return self.filter(block).first
    }
    
    /// Verify that all objects in array do not match the block.
    ///
    /// - parameter block: matching block
    /// - returns: true, if no objects match the block. If any object matches - false
    func ck_none( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) == nil
    }
    
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
    
    /// Accumulate objects using block
    ///
    /// - parameter initial: initial value for accumulating variable
    /// - parameter combine: block to execute for each element. Contains current value for accumulation variable and current element.
    /// - returns: Accumulated value
    func ck_reduce<U>(initial: U, combine: (U, Element) -> U) -> U
    {
        return self.reduce(initial, combine: combine)
    }
    
    /// Find elements that do not match provided block.
    /// This is the reverse for ck_select method
    ///
    /// - parameter block: block to reject
    /// - returns: Array, containing elements, that do not match block.
    func ck_reject( block: (Element) -> Bool) -> [Element] {
        return self.ck_select({ element -> Bool in
            return !block(element)
        })
    }
    
    /// Find all elements in array, that match provided block.
    ///
    /// - parameter block: block to match against
    /// - returns: Array of objects, that match block criteria
    func ck_select( block : (Element) -> Bool) -> [Element] {
        return self.filter(block)
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