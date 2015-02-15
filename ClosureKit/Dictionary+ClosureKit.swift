//
//  Dictionary+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

extension Dictionary {
    
    /// Verify, that all key-value pairs match provided block.
    ///
    /// :param: block matching block
    /// :returns: true, if all key-value pairs match provided block. If at least one pair does not match - false.
    func ck_all( block: (Element) -> Bool) -> Bool {
        for (key,value) in self {
            if !block(key,value) {
                return false
            }
        }
        return true
    }
    
    /// Verify that at least one key-value matches block.
    ///
    /// :param: block matching block
    /// :returns: true, if any key-value pair matches block. If none matches - false.
    func ck_any( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) != nil
    }
    
    /// Loops over elements in Dictionary and executes given block with eack key value tuple.
    ///
    /// :param: block block to execute
    func ck_each(block: (Element) -> ())
    {
        for (key,value) in self {
            block(key,value)
        }
    }
    
    /// Create dictionary with transformed values. Keys of new dictionary remain the same, but values are a result of executing provided block on key-value pair in current dictionary
    ///
    /// :param: block transformation block
    /// :returns: Transformed dictionary
    func ck_map<U>(block: (Key,Value) -> U) -> [Key:U]
    {
        var result = [Key:U]()
        self.ck_each { (key, value) -> () in
            result[key] = block(key,value)
        }
        return result
    }
    
    /// Find first element in Dictionary that is matching the block. If none matches, return nil.
    ///
    /// :param: block matching block
    /// :returns: (key,value) tuple or nil, if not found
    func ck_match(block: (Element) -> Bool) -> Element?
    {
        for (key,value) in self {
            if block(key,value) {
                return (key,value)
            }
        }
        return nil
    }
    
    /// Verify, that none of the key-value pairs match provided block.
    ///
    /// :param: block matching block
    /// :returns: true, if none of key-value pairs match block. If at least one pair matches - false.
    func ck_none( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) == nil
    }
    
    /// Filter dictionary, deleting all key-value pairs, that do not match provided block.
    ///
    /// :param: block matching block
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
    /// :param: block matching block
    mutating func ck_performReject( block: (Element) -> Bool)
    {
        self.ck_performSelect { (key, value) -> Bool in
            return !block(key,value)
        }
    }
    
    /// Find key-value pairs, that do not match provided block. This is reverse of ck_select method
    ///
    /// :param: block matching block
    /// :returns: Dictionary, containing key-value pairs, that do not match block
    func ck_reject( block: (Element) -> Bool) -> [Key:Value]
    {
        return self.ck_select({ (key,value) -> Bool in
            return !block(key,value)
        })
    }
    
    /// Find all key-value pairs, that match provided block
    ///
    /// :param: block matching block
    /// :returns: Dictionary, containing key-value pairs, that match block
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