//
//  SuffixSequence.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 08.05.2022.
//

import Foundation

struct SuffixSequence: Sequence {
    let word: String
    
    func makeIterator() -> some IteratorProtocol {
        return SuffixIterator(string: word)
    }
}

