//
//  Extentions.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 12.05.2022.
//

import Foundation

extension Sequence where Element: Hashable {
    func makeUnique() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}

extension Int {
    static func showNumber(n: Int) -> String {
        if n > 1 { return "\(n)" }
        return ""
    }
}
