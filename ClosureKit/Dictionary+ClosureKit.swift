//
//  Dictionary+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func ck_each(block: (Element) -> ())
    {
        for (key,value) in self {
            block(key,value)
        }
    }
    
    func ck_match(block: (Element) -> Bool) -> Element?
    {
        for (key,value) in self {
            if block(key,value) {
                return (key,value)
            }
        }
        return nil
    }
    
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
    
    func ck_map<U>(block: (Key,Value) -> U) -> [Key:U]
    {
        var result = [Key:U]()
        self.ck_each { (key, value) -> () in
            result[key] = block(key,value)
        }
        return result
    }
    
    func ck_reject( block: (Element) -> Bool) -> [Key:Value]
    {
        return self.ck_select({ (key,value) -> Bool in
            return !block(key,value)
        })
    }
    
    func ck_any( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) != nil
    }
    
    func ck_none( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) == nil
    }
    
    func ck_all( block: (Element) -> Bool) -> Bool {
        for (key,value) in self {
            if !block(key,value) {
                return false
            }
        }
        return true
    }
    
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
    
    mutating func ck_performReject( block: (Element) -> Bool)
    {
        self.ck_performSelect { (key, value) -> Bool in
            return !block(key,value)
        }
    }
}