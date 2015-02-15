//
//  TestStruct.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

struct Struct {
    var int = 5
    var string = "bar"
    
    init(int: Int, string: String)
    {
        self.int = int
        self.string = string
    }
}

extension Struct
{
    static func structsArray() -> [Struct]
    {
        return [Struct(int: 1, string: "a"), Struct(int: 2, string: "b"),Struct(int: 3, string: "c")]
    }
}