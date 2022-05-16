//
//  SortingProcess.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 15.05.2022.
//

import SwiftUI

struct SortType {
    var names: [Suffix]
}

protocol ISortType {
    associatedtype SortType
    func show(type: Modes, words: [Suffix]) -> SortType
}

class SortingProcess: ISortType {
    func show(type: Modes, words: [Suffix]) -> SortType {
        switch type {
        case .norm, .unique:
            return SortType(names: words)
        case .asc:
            return SortType(names: words.sorted(by: <))
        case .des:
            return SortType(names: words.sorted(by: >))
        }
    }
}
