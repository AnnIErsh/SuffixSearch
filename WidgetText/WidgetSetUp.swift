//
//  WidgetSetUp.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 22.05.2022.
//

import Foundation
import WidgetKit

@propertyWrapper
struct WidgetSetUp<T: Codable> {
    let key: String
    let defaultValue: [T]
    let suffixDefaults: UserDefaults
    
    init(_ key: String, _ defaultValue: [T], _ suffixDefaults: UserDefaults) {
        self.key = key
        self.defaultValue = defaultValue
        self.suffixDefaults = suffixDefaults
    }
    
    var wrappedValue: [T] {
        get {
            if let data = suffixDefaults.object(forKey: key) as? Data,
               let user = try? JSONDecoder().decode([T].self, from: data) {
                return user
            }
            return  defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                suffixDefaults.set(encoded, forKey: key)
            }
        }
    }
}

enum Settings {
    @WidgetSetUp("suffix",
                 [Suffix(name: "start")],
                 UserDefaults(suiteName: "group.anniersh.CopyTextExt05")!)
    static var suff: [Suffix]
}

