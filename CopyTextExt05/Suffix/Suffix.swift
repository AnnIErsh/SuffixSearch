//
//  Suffix.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 16.05.2022.
//

import Foundation

protocol ISuffix: CustomStringConvertible, Comparable, Hashable { }

struct Suffix: ISuffix {
    let name: String
    var description: String { return name }
    
    static func ==(lhs: Suffix, rhs: Suffix) -> Bool {
        return lhs.name == rhs.name
    }

    static func <(lhs: Suffix, rhs: Suffix) -> Bool {
        return lhs.name.lowercased() < rhs.name.lowercased()
    }
    
    static func >(lhs: Suffix, rhs: Suffix) -> Bool {
        return lhs.name.lowercased() > rhs.name.lowercased()
    }
}

