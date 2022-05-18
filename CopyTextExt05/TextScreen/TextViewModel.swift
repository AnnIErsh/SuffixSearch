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
    @Published var tops: [Suffix] = []
    var mode: Modes {
        get {
            head
        }
        set {
            head = newValue
        }
    }
    
    var removeSpaces: Bool? {
        didSet {
            var arr = words.map { str in
                str.replacingOccurrences(of: "^\\s+|\\s+|\\s+$", with: "", options: .regularExpression)
            }
            arr.removeAll { str in
                str == ""
            }
            words = arr
        }
    }
    
    var indexes: [Int] = [0]
    var sequences: [SuffixSequence] = []
    var suffixes: [Suffix] = []
    
    var uniques: NSCountedSet {
        NSCountedSet(array: suffixes)
    }
    
    var topOrNorm: [Any] {
        if mode == .norm { return Array(uniques) }
        if mode == .tops { return Array(tops) }
        return []
    }

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
            let suffSeq = i.suffix(n)
            let suffArr = suffSeq as! [String]
            for el in suffArr {
                suffixes.append(Suffix(name: el))
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
    
    func showTopTen() {
        let arr = Array(uniques) as! [Suffix]
        var arr2 = arr.filter { i in
            i.name.count == 3
        }
        arr2.sort { i, j in
            let numb = uniques.count(for: i)
            let numb2 = uniques.count(for: j)
            return numb > numb2
        }
        let res = Array(arr2.prefix(10))
        tops = res
        print(tops)
    }
    
    func resetData() {
        words = []
        sequences = []
        suffixes = []
        tops = []
    }
}
