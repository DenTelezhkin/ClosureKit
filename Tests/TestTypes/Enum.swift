//
//  Enum.swift
//  ClosureKit
//
//  Created by Denys Telezhkin on 15.02.15.
//  Copyright (c) 2015 MLSDev. All rights reserved.
//

enum Enum {
    case Foo
    case Bar
}

extension Enum {
    static func enumArray() -> [Enum]
    {
        return [.Foo,.Bar]
    }
}