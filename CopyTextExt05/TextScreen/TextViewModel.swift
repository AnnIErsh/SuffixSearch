//
//  TextViewModel.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 04.05.2022.
//

import Foundation

final class TextViewModel: ObservableObject {
    @Published var words: [String] = []
    @Published var head: Modes = .norm
    var mode: Modes {
        get {
            head
        }
        set {
            head = newValue
        }
    }
    
    var indexes: [Int] = [0]
    var sequences: [SuffixSequence] = []
    var suffixes: [Suffix] = []
    
    var uniques: NSCountedSet {
        NSCountedSet(array: suffixes)
    }
    
//    var uniqueSuffixes: [Suffix: Int] {
//        var dict: [Suffix: Int] = [:]
//        _ = suffixes.map {
//            if let value: Int = dict[$0]  {
//                dict[$0] = value + 1
//            } else {
//                dict[$0] = 1
//            }
//        }
//        return dict
//    }
//    
//    var keys: [Suffix] {
//        return Array(uniqueSuffixes.keys)
//    }
//    
//    var values: [Int] {
//        Array(uniqueSuffixes.values)
//    }

    func fillArrayWithSequence() {
        for i in words {
            sequences.append(SuffixSequence(word: i))
        }
    }

    func fillArrayWithSuffixes() {
        var j = 0
        var n = 0

        for i in sequences {
            suffixes.append(Suffix(name: words[j]))
            n += words[j].count
            indexes.append(n)
            for j in i {
                let ss = j as! String
                suffixes.append(Suffix(name: ss))
            }
            j += 1
        }
    }
    
    func setOrderSuffix(currentHead: Modes) -> [Suffix] {
        var suff: [Suffix] {
            let process = SortingProcess()
            let type = process.show(type: currentHead, words: suffixes)
            return type.names
        }
        return suff
    }
        
    func resetData() {
        words = []
        sequences = []
        suffixes = []
    }
}
