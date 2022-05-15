//
//  SuffixIterator.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 08.05.2022.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    private var suffix: SuffixModel
    
    init(string: String) {
        self.suffix =  SuffixModel(string: string, count: string.count)
    }
    
    mutating func next() -> String? {
        if suffix.count >= 2 {
            suffix.string.removeFirst()
            suffix.count -= 1
            return suffix.string
        }
        return nil
    }
}
