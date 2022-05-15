//
//  TextScreen.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 04.05.2022.
//

import SwiftUI

struct TextScreen: View {
    @EnvironmentObject var textViewModel: TextViewModel
    @State private var text: String = ""
    
    var body: some View {
        TextField("add your text", text: $text) { edit in
            print("is editing \(edit)")
        } onCommit: {
            textViewModel.words = text.components(separatedBy: " ")
            textViewModel.words.removeLast()
            textViewModel.fillArrayWithSequence()
            textViewModel.fillArrayWithSuffixes()
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

