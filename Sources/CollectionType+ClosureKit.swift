//
//  CollectionType+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 27.09.15.
//  Copyright © 2015 MLSDev. All rights reserved.
//

import Foundation

public extension Collection
{
    /// Find first element in Collection that is matching the block.
    /// If none matches, return nil
    ///
    /// - parameter block: block to match against
    /// - returns: Object, if found, nil if not.
    func ck_match(_ block : (Self.Iterator.Element) -> Bool) -> Self.Iterator.Element? {
        return self.filter(block).first
    }
    
    /// Verify that at least one object in Collection matches the block.
    ///
    /// - parameter block: matching block
    /// - returns: true, if any object matches the block. If none matches - false
    func ck_any(_ block : (Self.Iterator.Element) -> Bool) -> Bool {
        return self.ck_match(block) != nil
    }
    
    /// Verify that all objects in Collection do not match the block.
    ///
    /// - parameter block: matching block
    /// - returns: true, if no objects match the block. If any object matches - false
    func ck_none(_ block: (Self.Iterator.Element) -> Bool) -> Bool {
        return self.ck_match(block) == nil
    }
    
    /// Verify, that all objects in Collection match the block
    ///
    /// - parameter block: matching block
    /// - returns: true, if all objects match the block. If any object does not match - false
    func ck_all(_ block: (Self.Iterator.Element) -> Bool) -> Bool {
        for (_, value) in self.enumerated() {
            var stop = false
            stop = !block(value)
            if stop {
                return false
            }
        }
        return true
    }
}
