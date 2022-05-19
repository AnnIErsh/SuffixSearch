//
//  AllSuffixScreen.swift
//  CopyTextExt05
//
//  Created by Anna Ershova on 18.05.2022.
//

import SwiftUI

struct AllSuffixScreen: View {
    @EnvironmentObject var textViewModel: TextViewModel
    
    var suffixes: [Suffix] {
        textViewModel.suffixes
    }
    
    var body: some View {
        normalView
    }
    
    private var normalView: AnyView {
        AnyView(List {
            ForEach(textViewModel.words.indices, id: \.self) { i in
                let arr = Array(textViewModel.words[i])
                let n = textViewModel.indexes[i]
                Section {
                    ForEach(arr.indices, id: \.self) { j in
                        Text(String((suffixes[n + j] as AnyObject).description))
                    }
                } header: {
                    Text(textViewModel.words[i])
                }
            }
        })
    }
}
