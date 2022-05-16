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
        self.suffix =  SuffixModel(string: string)
    }
    
    mutating func next() -> String? {
        if suffix.string.count >= 2 {
            suffix.string.removeFirst()
            return suffix.string
        }
        return nil
    }
}
