//
//  NSArrayTestCase.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

import XCTest
import ClosureKit

class ArrayTestCase: XCTestCase {

    let ints = [1,2,3]
    let strings = ["a","b","c"]
    
    func testAll() {
        let dict = [1:2, 3:4]
        XCTAssertTrue(dict.ck_all { $0.0 > 0 } )
        XCTAssertFalse(dict.ck_all { $0.1 < 3} )
    }

    func testEach()
    {
        var total = 0
        var totalStrings = ""
        ints.ck_each { (element) -> Void in
            total += element
        }
        strings.ck_each { (element) -> Void in
            totalStrings += element
        }
        
        XCTAssertEqual(total, 6)
        XCTAssertEqual(totalStrings, "abc")
    }
    
    func testMatch() {
        let moreThan1 = ints.ck_match { (element) -> Bool in
            return element > 1
        }
        let nilMatch = strings.ck_match { (element) -> Bool in
            return element == "d"
        }
        
        let foundStruct = Struct.structsArray().ck_match { value -> Bool in
            return value.int == 3
        }
        
        XCTAssertNotNil(moreThan1)
        if moreThan1 != nil {
            XCTAssertEqual(moreThan1!, 2)
        }
        XCTAssertNil(nilMatch)
        XCTAssert(foundStruct != nil)
        if foundStruct != nil {
            XCTAssertEqual(foundStruct!.string, "c")
        }
    }
    
    func testReject() {
        let foo = ints.ck_reject { (element) -> Bool in
            return element > 1
        }
        XCTAssertEqual(foo, [1])
    }
    
    func testMap() {
        let transformed = ints.ck_map { (element) -> String in
            return self.strings[element-1]
        }
        
        XCTAssertEqual(transformed, strings)
    }
    
    func testAny()
    {
        let exists = ints.ck_any { (element) -> Bool in
            element > 2
        }
        let notExists = ints.ck_any { (element) -> Bool in
            element < 0
        }
        
        XCTAssertTrue(exists)
        XCTAssertFalse(notExists)
    }
    
    func testNone()
    {
        let none = ints.ck_none { (element) -> Bool in
            return element > 3
        }
        
        let some = ints.ck_none { (element) -> Bool in
            return element == 1
        }
        
        XCTAssert(none)
        XCTAssertFalse(some)
    }
    
    func testPerformSelect()
    {
        var mutableInts = [1,2,3]
        mutableInts.ck_performSelect { (element) -> Bool in
            return element > 1
        }
        
        XCTAssertEqual(mutableInts, [2,3])
    }
    
    func testPerformReject()
    {
        var mutableInts = [1,2,3]
        mutableInts.ck_performReject { (element) -> Bool in
            return element>2
        }
        
        XCTAssertEqual(mutableInts, [1,2])
    }
}
