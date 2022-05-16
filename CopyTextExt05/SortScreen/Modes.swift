//
//  Modes.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 12.05.2022.
//

import Foundation

enum Modes: String, CaseIterable {
    case norm = "default"
    case unique = "unique"
    case asc = "ASC"
    case des = "DESC"
}

final class ModeNames {
    static let shared = ModeNames()
    lazy var modes = Modes.allCases
}
