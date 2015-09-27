//
//  Dictionary+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

public extension Dictionary {
    
    /// Filter dictionary, deleting all key-value pairs, that do not match provided block.
    ///
    /// - parameter block: matching block
    mutating func ck_performSelect( block: (Key,Value) -> Bool)
    {
        var keysToRemove = [Key]()
        
        for (key,value) in self {
            if !block(key,value) {
                keysToRemove.append(key)
            }
        }
        
        for key in keysToRemove {
            self.removeValueForKey(key)
        }
    }
    
    /// Filter dictionary, deleting all key-value pairs, that match provided block. This is reverse for ck_performSelect method.
    ///
    /// - parameter block: matching block
    mutating func ck_performReject( block: (Key,Value) -> Bool)
    {
        self.ck_performSelect { (key, value) -> Bool in
            return !block(key,value)
        }
    }
    
    /// Find key-value pairs, that do not match provided block. This is reverse of ck_select method
    ///
    /// - parameter block: matching block
    /// - returns: Dictionary, containing key-value pairs, that do not match block
    func ck_reject( block: (Key,Value) -> Bool) -> [Key:Value]
    {
        return self.ck_select({ (key,value) -> Bool in
            return !block(key,value)
        })
    }
    
    /// Find all key-value pairs, that match provided block
    ///
    /// - parameter block: matching block
    /// - returns: Dictionary, containing key-value pairs, that match block
    func ck_select( block: (Element) -> Bool) -> [Key:Value]
    {
        var result: [Key:Value] = Dictionary()
        
        for (key,value) in self {
            if block(key,value)
            {
                result[key] = value
            }
        }
        return result
    }
}