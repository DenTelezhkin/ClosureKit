//
//  DictionaryTestCase.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

import XCTest
import ClosureKit

class DictionaryTestCase: XCTestCase {

    let dictionary = [1: "a", 2: "b", 3: "c"]
    
    func testMatch()
    {
        if let (key,value) = dictionary.ck_match({ (key, value) -> Bool in key == 2 }) {
            XCTAssertEqual(key, 2)
            XCTAssertEqual(value, "b")
        }
        else {
            XCTFail("ck_match should have returned value")
        }
        
        let notFound = dictionary.ck_match { (key, value) -> Bool in
            value == "d"
        }
        
        XCTAssert(notFound == nil)
    }

    func testSelect() {
        let moreThanOne = dictionary.ck_select { (key,value) -> Bool in
            return key > 1
        }
        
        let moreThanFour = dictionary.ck_select { (key,value) -> Bool in
            return key > 4
        }
        
        XCTAssert(moreThanOne[2] == "b")
        XCTAssert(moreThanOne[3] == "c")
        XCTAssertNil(moreThanOne[1])
        XCTAssertEqual(moreThanFour.count,0)
    }
    
    func testReject() {
        let rejectMoreThan1 = dictionary.ck_reject { (key,value) -> Bool in
            return key > 1
        }
        
        let rejectMoreThan0 = dictionary.ck_reject { (key,value) -> Bool in
            return key > 0
        }
        
        XCTAssertEqual(rejectMoreThan1.count, 1)
        XCTAssert(rejectMoreThan1[1] == "a")
        XCTAssertEqual(rejectMoreThan0.count, 0)
    }
    
    func testAny() {
        let contains = dictionary.ck_any { (key,value) -> Bool in
            return key == 3
        }
        let doesNotContain = dictionary.ck_any { (key,value) -> Bool in
            return value == "d"
        }
        
        XCTAssert(contains)
        XCTAssertFalse(doesNotContain)
    }
    
    func testNone() {
        let none = dictionary.ck_none { (key,value) -> Bool in
            return key > 4
        }
        let some = dictionary.ck_none { (key,value) -> Bool in
            return value == "b"
        }
        
        XCTAssert(none)
        XCTAssertFalse(some)
    }
    
    func testAll() {
        let all = dictionary.ck_all { (key,value) -> Bool in
            return key > 0
        }
        let some = dictionary.ck_all { (key,value) -> Bool in
            return value == "b"
        }
        
        XCTAssert(all)
        XCTAssertFalse(some)
    }
    
    func testPerformSelect()
    {
        var mutableDictionary = [1:Struct(int: 1, string: "a"),2:Struct(int: 2, string: "b")]
        
        mutableDictionary.ck_performSelect { (key,value) -> Bool in
            return value.int > 1
        }
        
        XCTAssertEqual(mutableDictionary.count, 1)
        XCTAssert(mutableDictionary[2]?.string == "b")
    }
    
    func testPerformReject()
    {
        var mutableDictionary = [1:Enum.foo,2:Enum.bar]
        
        mutableDictionary.ck_performReject { (key,value) -> Bool in
            return value == Enum.bar
        }
        
        XCTAssertEqual(mutableDictionary.count, 1)
        XCTAssert(mutableDictionary[1] == Enum.foo)
    }
}
