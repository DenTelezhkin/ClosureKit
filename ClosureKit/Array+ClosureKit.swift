//
//  NSArray+ClosureKit.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

import Foundation

extension Array {
    
    func ck_each(block: (Element) -> ())
    {
        for element in self {
            block(element)
        }
    }
    
    func ck_match(block : (Element) -> Bool) -> Element? {
        return self.filter(block).first
    }
    
    func ck_select( block : (Element) -> Bool) -> [Element] {
        return self.filter(block)
    }
    
    func ck_reject( block: (Element) -> Bool) -> [Element] {
        return self.ck_select({ element -> Bool in
            return !block(element)
        })
    }
    
    func ck_map<U>(transform : (Element) -> U ) -> [U] {
        return self.map(transform)
    }
    
    func ck_reduce<U>(initial: U, combine: (U, Element) -> U) -> U
    {
        return self.reduce(initial, combine: combine)
    }
    
    func ck_any( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) != nil
    }
    
    func ck_none( block: (Element) -> Bool) -> Bool {
        return self.ck_match(block) == nil
    }
    
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
}