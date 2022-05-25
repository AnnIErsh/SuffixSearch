//
//  Extentions.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 12.05.2022.
//

import Foundation

extension Int {
    static func showNumber(n: Int) -> String {
        if n > 1 { return "\(n)" }
        return ""
    }
}

extension UserDefaults {
    class func clean() {
        guard let aValidIdentifier = Bundle.main.bundleIdentifier else { return }
        standard.removePersistentDomain(forName: aValidIdentifier)
        standard.synchronize()
    }
}
