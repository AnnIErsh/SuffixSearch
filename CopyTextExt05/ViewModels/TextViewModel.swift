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
    @Published var tops: NSCountedSet = []
   
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
    
    var suffmodes: [Suffix] {
        let process = SortingProcess()
        let type = process.show(type: head, words: suffixes)
        return type.names
    }
    
    var uniques: NSCountedSet {
        NSCountedSet(array: suffixes)
    }
    
    var topOrNorm: [Any] {
        switch mode {
        case .norm:
            return Array(uniques)
        case .tops:
            return Array(tops)
        case .asc, .des:
            return Array(NSOrderedSet(array: suffmodes))
        }
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
    
    func showTopTen(searched: [Suffix]) {
        var arr = searched
        arr.removeAll(where: { $0.name.lowercased().count != 3 })
        tops.addObjects(from: arr)
        print("after submit:", tops)
    }
    
    func sortByAppearances() -> [Any] {
        let sorted = topOrNorm.sorted { i, j in
            let numb =  tops.count(for: i)
            let numb2 = tops.count(for: j)
            let wasCounted = uniques.count(for: i)
            let wasCounted2 = uniques.count(for: j)
            return (numb * wasCounted) > (numb2 * wasCounted2)
        }
        let arr = Array(sorted.prefix(10))
        return arr
    }
        
    func setUp(withText text: String) {
        resetData()
        words = text.components(separatedBy: " ")
        removeSpaces = true
        fillArrayWithSequence()
        fillArrayWithSuffixes()
    }
    
    func resetData() {
        words = []
        indexes = [0]
        tops = []
        sequences = []
        suffixes = []
        tops = []
    }
    
    func addOtherDataStructure() -> [String] {
        return ["years,", "arch", "that", "has", "normal", "ayout.", "mal", "fault", "dable", "page", "ackages", "racted", "able", "have", "ormal", "eadable", "tablished", "as", "stablished", "readable", "age", "adable", "eader", "a", "ault", "accident,", "aking", "search", "infancy.", "acted", "tracted", "ars,", "stracted", "arious", "distracted", "earch", "ears,", "act", "reader", "rmal", "many", "various", "at", "fancy.", "packages", "established", "ave", "and", "kages", "ancy.", "nfancy.", "ckages", "default", "ader", "any", "ablished", "making", "hat", "istracted", "layout.", "many", "fact", "ages", "al", "efault"]
    }
    
    func addBigArray() -> [String] {
        var arr: [String] = []
        for i in 1...1000 {
            arr.append("\(i)")
        }
        return arr
    }
}
