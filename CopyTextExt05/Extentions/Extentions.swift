//
//  Extentions.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 12.05.2022.
//

import Foundation
import SwiftUI

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

extension Color {
    static func timeColor(value: Double, sortedItems: [Double]) -> Color {
        let step: Double = Double((100 / sortedItems.count) + (100 % sortedItems.count))
        let i: Double = {
            var j = Int(sortedItems.firstIndex(of: value) ?? 0)
            if j == sortedItems.count - 1 {
                j = 100
            }
            return Double(j)
        }()
        let R: Double = (255 * (i * step)) / 100
        let G: Double = (255 * (100 - (i * step))) / 100
        let B: Double = 0
        return Color(red: R, green: G, blue: B)
    }
}

extension String {
    static func showFirstText() -> String {
        let text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        return text
    }
    
    static func showSecondText() -> String {
        let text = "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like)."
        return text
    }
}
