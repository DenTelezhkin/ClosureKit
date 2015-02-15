//
//  NSArray+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

extension Array {
    
    /// Loops over elements in array and executes given block with each element
    ///
    /// :param: block block to execute
    func ck_each(block: (Element) -> ())
    {
        for element in self {
            block(element)
        }
    }
    
    /// Find first element in array that is matching the block.
    /// If none matches, return nil
    ///
    /// :param: block block to match against
    /// :returns: Object, if found, nil if not.
    func ck_match(block : (Element) -> Bool) -> Element? {
        return self.filter(block).first
    }
    
    /// Find all elements in array, that match provided block.
    ///
    /// :param: block block to match against
    /// :returns: Array of objects, that match block criteria
    func ck_select( block : (Element) -> Bool) -> [Element] {
        return self.filter(block)
    }
    
    /// Find elements that do not match provided block. 
    /// This is the reverse for ck_select method
    ///
    /// :param: block block to reject 
    /// :returns: Array, containing elements, that do not match block.
    func ck_reject( block: (Element) -> Bool) -> [Element] {
        return self.ck_select({ element -> Bool in
            return !block(element)
        })
    }
    
    /// Create array of new values, that is constructed by calling block on each element of current array.
    ///
    /// :param: transform mapping block
    /// :returns: Array of transformed values
    func ck_map<U>(transform : (Element) -> U ) -> [U] {
        return self.map(transform)
    }
    
    /// Accumulate objects using block
    ///
    /// :param: initial initial value for accumulating variable
    /// :param: combine block to execute for each element. Contains current value for accumulation variable and current element.
    /// :returns: Accumulated value
    func ck_reduce<U>(initial: U, combine: (U, Element) -> U) -> U
    {
        return self.reduce(initial, combine: combine)
    }
    
    /// Verify that at least one object in array matches the block.
    ///
    /// :param: block matching block
    /// :returns: true, if any object matches the block. If none matches - false
    func ck_any( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) != nil
    }
    
    /// Verify that all objects in array do not match the block.
    ///
    /// :param: block matching block
    /// :returns: true, if no objects match the block. If any object matches - false
    func ck_none( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) == nil
    }
    
    /// Verify, that all objects in array match the block
    ///
    /// :param: block matching block
    /// :returns: true, if all objects match the block. If any object does not match - false
    func ck_all( block: (Element) -> Bool) -> Bool {
        for (index, value) in enumerate(self) {
            var stop = false;
            stop = block(value)
            if stop {
                return false;
            }
        }
        return true
    }
    
    /// Filter array, deleting all objects, that do not match block
    ///
    /// :param: block matching block.
    mutating func ck_performSelect(block: (Element) -> Bool) {
        var indexes = [Int]()
        for (index,element) in enumerate(self) {
            if !block(element) { indexes.append(index)}
        }
        
        self.removeAtIndexes(indexes)
    }
    
    /// Filter array, deleting all objects, that match block
    ///
    /// :param: block matching block
    mutating func ck_performReject(block: (Element) -> Bool) {
        return self.ck_performSelect({ (element) -> Bool in
            return !block(element)
        })
    }
}

private extension Array
{
    mutating func removeAtIndexes( indexes: [Int]) {
        for index in indexes.sorted(>) {
            self.removeAtIndex(index)
        }
    }
}