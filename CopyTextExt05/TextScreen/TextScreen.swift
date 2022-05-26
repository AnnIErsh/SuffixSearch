//
//  TextScreen.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 04.05.2022.
//

import SwiftUI
import WidgetKit

struct TextScreen: View {
    @EnvironmentObject var textViewModel: TextViewModel
    @State private var text: String = ""
    
    var body: some View {
        TextField("add your text", text: $text) { edit in
            print("is editing \(edit)")
        } onCommit: {
            textViewModel.setUp(withText: text)
            print("before append: ", Settings.suff)
            Settings.suff = textViewModel.suffixes
            print("after append: ", Settings.suff)
            WidgetCenter.shared.reloadAllTimelines()
            text = ""
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

